Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRH1UfB>; Tue, 28 Aug 2001 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269197AbRH1Uev>; Tue, 28 Aug 2001 16:34:51 -0400
Received: from ns.suse.de ([213.95.15.193]:49168 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268957AbRH1Ueh>;
	Tue, 28 Aug 2001 16:34:37 -0400
To: Brad Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010828193317.96277.qmail@web10901.mail.yahoo.com>
X-Yow: Please come home with me...  I have Tylenol!!
From: Andreas Schwab <schwab@suse.de>
Date: 28 Aug 2001 22:34:54 +0200
In-Reply-To: <20010828193317.96277.qmail@web10901.mail.yahoo.com> (Brad Chapman's message of "Tue, 28 Aug 2001 12:33:17 -0700 (PDT)")
Message-ID: <jevgj7ditt.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.105
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Chapman <kakadu_croc@yahoo.com> writes:

|> Everyone,
|> 
|> 	From reading this thread, I believe I have come up with several reasons,
|> IMHO, why the old min()/max() macros were not usable:
|> 
|> 	- They did not take into account non-typesafe comparisons
|> 	- They were too generic
|> 	- Some versions, IIRC, relied on typeof()
|> 	- They did not take into account signed/unsigned conversions
|> 
|> 	I have also discovered one problem with the new three-arg min()/max()
|> macro: it forces both arguments to be the same, thus preventing signed/unsigned
|> comparisons.

There is no such thing as signed/unsigned comparision in C.  Any
comparison is either signed or unsigned, depending on whether the common
type of arguments after applying the usual arithmetic conversions is
signed or unsigned.

|> 	Thus, I have a humble idea: add another type argument!

This does not bye you anything because the there can only be one common
type anyway.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
