Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270822AbRH1VFL>; Tue, 28 Aug 2001 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270154AbRH1VFC>; Tue, 28 Aug 2001 17:05:02 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:8654
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S270919AbRH1VEw>; Tue, 28 Aug 2001 17:04:52 -0400
Message-ID: <3B8C0773.2D9314A4@nortelnetworks.com>
Date: Tue, 28 Aug 2001 17:04:51 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010828204207.12623.qmail@web10908.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Chapman wrote:
> 
> Mr. Schwab,
> 
> --- Andreas Schwab <schwab@suse.de> wrote:
> > Brad Chapman <kakadu_croc@yahoo.com> writes:
> >
> > |> Everyone,
> > |>
> > |>    From reading this thread, I believe I have come up with several reasons,
> > |> IMHO, why the old min()/max() macros were not usable:
> > |>
> > |>    - They did not take into account non-typesafe comparisons
> > |>    - They were too generic
> > |>    - Some versions, IIRC, relied on typeof()
> > |>    - They did not take into account signed/unsigned conversions
> > |>
> > |>    I have also discovered one problem with the new three-arg min()/max()
> > |> macro: it forces both arguments to be the same, thus preventing signed/unsigned
> > |> comparisons.
> >
> > There is no such thing as signed/unsigned comparision in C.  Any
> > comparison is either signed or unsigned, depending on whether the common
> > type of arguments after applying the usual arithmetic conversions is
> > signed or unsigned.
> 
>         Then why, IIRC, are the kernel hackers so upset about how the three-arg
> macros _prevent_ signed/unsigned comparisons? Apparently the ability to compare
> signed/unsigned variables must have _some_ significance....

Are they?  The most salient objections I've seen are to do with compatibility
and code maintenance.

Since the underlying hardware has to compare either signed or unsigned numbers,
you will always have to eventually cast to some common type.  The three arg
macro simply makes it explicit *what* that common type is.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
