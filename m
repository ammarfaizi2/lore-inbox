Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSFFNBh>; Thu, 6 Jun 2002 09:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSFFNBg>; Thu, 6 Jun 2002 09:01:36 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:42764 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316768AbSFFNBg>;
	Thu, 6 Jun 2002 09:01:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: jlmales@yahoo.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question Regarding "EXTRAVERSION" Specification 
In-Reply-To: Your message of "Thu, 06 Jun 2002 03:09:29 -0400."
             <20020606030929.460bec3e.jlmales@softhome.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 23:01:27 +1000
Message-ID: <4708.1023368487@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 03:09:29 -0400, 
"John L. Males" <jlmales@softhome.net> wrote:
>***** Please note I am not on the Linux Kernel Mailing List.  Please
>be so kind as to BCC copy me in on any reply to this inquiry.  Thanks
>The questions are:
>
>  1) Is there a specification that states the maximum length that the
>"EXTRAVERSION" string may be?

The total length $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
must not exceed 64 characters.  Break that limit and you get garbage in
uname -r.

>  2) Does the Kernel make/build process enforce any specified limit of
>(1) above?

kbuild 2.5 enforces the limit, the existing kernel build code does not.
I sent a patch to Linus four times back in the 2.4.15 days, he
completely ignored it.  Linus does not care about kernel build
problems.

I will dig out the patch and send it to Marcelo.

