Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269593AbRH1UmL>; Tue, 28 Aug 2001 16:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269770AbRH1UmB>; Tue, 28 Aug 2001 16:42:01 -0400
Received: from web10908.mail.yahoo.com ([216.136.131.44]:24070 "HELO
	web10908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269593AbRH1Ulu>; Tue, 28 Aug 2001 16:41:50 -0400
Message-ID: <20010828204207.12623.qmail@web10908.mail.yahoo.com>
Date: Tue, 28 Aug 2001 13:42:07 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <jevgj7ditt.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Schwab,

--- Andreas Schwab <schwab@suse.de> wrote:
> Brad Chapman <kakadu_croc@yahoo.com> writes:
> 
> |> Everyone,
> |> 
> |> 	From reading this thread, I believe I have come up with several reasons,
> |> IMHO, why the old min()/max() macros were not usable:
> |> 
> |> 	- They did not take into account non-typesafe comparisons
> |> 	- They were too generic
> |> 	- Some versions, IIRC, relied on typeof()
> |> 	- They did not take into account signed/unsigned conversions
> |> 
> |> 	I have also discovered one problem with the new three-arg min()/max()
> |> macro: it forces both arguments to be the same, thus preventing signed/unsigned
> |> comparisons.
> 
> There is no such thing as signed/unsigned comparision in C.  Any
> comparison is either signed or unsigned, depending on whether the common
> type of arguments after applying the usual arithmetic conversions is
> signed or unsigned.

	Then why, IIRC, are the kernel hackers so upset about how the three-arg
macros _prevent_ signed/unsigned comparisons? Apparently the ability to compare
signed/unsigned variables must have _some_ significance....
	
> 
> |> 	Thus, I have a humble idea: add another type argument!
> 
> This does not bye you anything because the there can only be one common
> type anyway.

	IDGT. What if you don't want a common type? What if you explicitly
_want_ to cast signed "up" to unsigned or unsigned "down" to signed?

> 
> Andreas.

Brad

> 
> -- 
> Andreas Schwab                                  "And now for something
> SuSE Labs                                        completely different."
> Andreas.Schwab@suse.de
> SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
> Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
