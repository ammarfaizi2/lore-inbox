Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317008AbSFFQtE>; Thu, 6 Jun 2002 12:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317010AbSFFQtD>; Thu, 6 Jun 2002 12:49:03 -0400
Received: from niobium.golden.net ([199.166.210.90]:59115 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP
	id <S317008AbSFFQtB>; Thu, 6 Jun 2002 12:49:01 -0400
Date: Thu, 6 Jun 2002 12:48:46 -0400
From: "John L. Males" <jlmales@yahoo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question Regarding "EXTRAVERSION" Specification
Message-Id: <20020606124846.28a10cbd.jlmales@yahoo.com>
Reply-To: jlmales@yahoo.com
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.hgBRc/hsdt:0bq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.hgBRc/hsdt:0bq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Keith,

First my appologies I mistype how to decode my eMail domain name in my
previous signature.  It is corrected now, and hopfully you be kind
enough to BCC me in any replies you make.

***** Please BCC me in on any reply, not CC me.  Two reasons, I am not
on the LKML, and second I am suffering BIG time with SPAM from posting
to the mailing list.  Thanks in advance. *****


>List:     linux-kernel
>Subject:  Re: Question Regarding "EXTRAVERSION" Specification
>From:     Keith Owens <kaos@ocs.com.au>
>Date:     2002-06-06 13:01:27
>[Download message RAW]

>On Thu, 6 Jun 2002 03:09:29 -0400, 
>"John L. Males" <jlmales@softhome.net> wrote:
>>***** Please note I am not on the Linux Kernel Mailing List.  Please
>>be so kind as to BCC copy me in on any reply to this inquiry. 
>Thanks>The questions are:
>>
>>  1) Is there a specification that states the maximum length that
>the>"EXTRAVERSION" string may be?
>
>The total length $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
>must not exceed 64 characters.  Break that limit and you get garbage
>in uname -r.

Ok, well I created a:

VERSION = 2
PATCHLEVEL = 2
SUBLEVEL = 20
EXTRAVERSION = -PentiumK6TSCCyrixIII-SMP-ow3
-PentiumK6-SMP-ow3

The Kernel itself seemed just fine with this, but various programs
like those to mkinitrd and LILO, not sure about GRUB as not able to
test all had big problems with it.  I had to keep it down to

EXTRAVERSION = -PentiumK6-SMP-ow3 before the supporting and dependant
on the Kernel in somewere ok with the original one I used above.

I was clearly within the 64 combined total indicated.  How it is
insured that this specification is tested for the "supporting" Kernel
elments and fixed to make everything in sync?

>
>>  2) Does the Kernel make/build process enforce any specified limit
>of>(1) above?
>
>kbuild 2.5 enforces the limit, the existing kernel build code does
>not. I sent a patch to Linus four times back in the 2.4.15 days, he
>completely ignored it.  Linus does not care about kernel build
>problems.

For what is worth, Linus, these are important elements.  Maybe not
"exciting" or challenging "development" items, but very important.


>I will dig out the patch and send it to Marcelo.

Keith, that would be wonderful.  I be happy to have a copy of the
patch just to keep for my records until it is incorporated into the
2.4.x tree.  AS FYI, I may not need up to 64, but knwing this fact is
helpful.  When I build "test" Kernels, I like to use the EXTRAVERSION
to indicate some the the Varients to the "stock" configuration.  Part
of my QA/Testing "habits" that I will skip the gory details why such
is done.

Marcelo, I know you decide on what is important and when it is
included in the mainstream 2.4.x kernel.  FWIIW, I would suggest that
there is no need to get this in the current 2.4.19-RCx kernel tree.  I
be most happy if it put on the 2.4.20-Pre To DO list and added there
if possible, or when you feel it is appropriate based on the code
impact it might have.

One other thought if I may for future consideration to implement.  It
would be really really helpful if when "EXTRAVERSION" = <string> that
a (prefix) "-" is automatically added so one does not need to remember
to include a "-" in the "EXTRAVERSION" string to neatly seperate the
Kernel version numbers from the "EXTRAVERSION" string.  Hint, the
existing "build" process seems to do this between the version numbers
of the Kernel automatically, but of course "." are the character of
choice in this case.  Just a thought :))  And when "EXTRAVERSION" =
NULL, of course no automatically generated "-" is generated for
"EXTRAVERSION".


Regards,

John L. Males
Willowdale, Ontario
Canada
06 June 2002 12:48


==================================================================
***** Please BCC me in on any reply, not CC me.  Two reasons, I am not
on the LKML, and second I am suffering BIG time with SPAM from posting
to the mailing list.  Thanks in advance. *****


Please BCC me by replacing yahoo.com after the "@" as follows"
TLD =         The last three letters of the word internet
Domain name = The first four letters of the word software,
              followed by the first four letters of the word
              homeless.
My appologies in advance for the jumbled eMail address
and request to BCC me, but SPAM has become a very serious
problem.  The eMail address in my header information is
not a valid eMail address for me.  I needed to use a valid
domain due to ISP SMTP screen rules.
--=.hgBRc/hsdt:0bq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjz/knsACgkQsrsjS27q9xb7rACg27vAFG4An295mRAUkLP/FCah
YZIAni1bZVWR9kGkDi16X+MI85U86gZx
=xARC
-----END PGP SIGNATURE-----

--=.hgBRc/hsdt:0bq--

