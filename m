Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319510AbSH3A3V>; Thu, 29 Aug 2002 20:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319536AbSH3A3V>; Thu, 29 Aug 2002 20:29:21 -0400
Received: from web40208.mail.yahoo.com ([66.218.78.69]:61512 "HELO
	web40208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319510AbSH3A3U>; Thu, 29 Aug 2002 20:29:20 -0400
Message-ID: <20020830003338.86493.qmail@web40208.mail.yahoo.com>
Date: Thu, 29 Aug 2002 17:33:38 -0700 (PDT)
From: mike heffner <mdheffner@yahoo.com>
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Frank.Otto@tc.pci.uni-heidelberg.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020830094825.75fd8519.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shephen,

I tried this early on, but I just tried it again to
make sure.  There is no noticeable effect from setting
apm=allow_ints at the boot prompt.  So either my
command is not getting set, or the BIOS itself is
restricting the interrupts?  Is there a way to check
that I did indeed allow interrupts?
  I don't know much about BIOS hacking, any
suggestions about how to get the code for the BIOS
(other than disassembling it)?  I bet Dell isn't going
to give it to me.  I am struggling to get them to even
understand the problem.

Thanks,
Mike


--- Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> OK, for the Dells, we autodetect the 4000 series and
> allow
> interrupts during BIOS calls, but not the 8000's
> (unless
> your RedHat patched kernel does this).  So could you
> try
> booting with "apm=allow_ints" on the command line
> (or load
> the apm modules with "allow_ints=1"). and try again.
>  If
> this changes things, then we need to add the 8100 to
> the
> list of things we automatically allow interrupts
> for.
> 
> The default from the very beginning has been to
> disable interrupts
> and on most machines this works fine.  The option of
> leaving
> interrupts enabled was introduced when we discovered
> that the
> Thinkpads won't resume if you disable them ...
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
