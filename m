Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbVCQMAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVCQMAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVCQLwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:52:19 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:64173 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S263063AbVCQLJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 06:09:22 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm4
Date: Thu, 17 Mar 2005 12:07:55 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org> <20050317011811.69062aa0.akpm@osdl.org> <200503171042.33558.petkov@uni-muenster.de>
In-Reply-To: <200503171042.33558.petkov@uni-muenster.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503171207.56147.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 March 2005 10:42, Borislav Petkov wrote:
> On Thursday 17 March 2005 10:18, Andrew Morton wrote:
> > Borislav Petkov <petkov@uni-muenster.de> wrote:
> > > Mar 17 09:19:28 zmei kernel: [    4.109241] PM: Checking swsusp image.
> > >  Mar 17 09:19:28 zmei kernel: [    4.109244] PM: Resume from disk
> > > failed. Mar 17 09:19:28 zmei kernel: [    4.112220] VFS: Mounted root
> > > (ext2 filesystem) readonly. Mar 17 09:19:28 zmei kernel: [    4.112465]
> > > Freeing unused kernel memory: 188k freed Mar 17 09:19:28 zmei kernel: [
> > > 4.142002] logips2pp: Detected unknown logitech mouse model 1 Mar 17
> > > 09:19:28 zmei kernel: [    4.274620] input: PS/2 Logitech Mouse on
> > > isa0060/serio1 [EOF]
> > >  <-- and here it stops waiting forever. What actually has to come next
> > > is the init process, i.e. something of the likes of:
> > >  INIT version x.xx loading
> > >  but it doesn't. And by the way, how do you debug this? serial console?
> >
> > Serial console would be useful.  Do sysrq-P and sysrq-T provide any info?
>
> Hmm,
> actually I haven't set up a serial console connection so let me try to
> establish one first and get back to you whenever I have some results.
>
> Boris.

Hi again,

since I don't have a 9-pin serial port on my laptop I've been trying to 
connect it with the testing machine over a 25-pin cable (on a 25-pin port), 
which, according to the Serial-HOWTO is doable in theory but doesn't seem 
that easy to do in practice. Setserial reports that the ports are ok:

setserial -a /dev/ttyS1
/dev/ttyS1, Line 1, UART: 16550A, Port: 0x02f8, IRQ: 3
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_normal skip_test

[other machine]:
setserial -a /dev/ttyS0
/dev/ttyS0, Line 0, UART: 16550A, Port: 0x03f8, IRQ: 4
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_normal skip_test

but minicom or other serial line communication utils do not send or receive 
any chars. Any ideas?

Boris.
