Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269140AbRHAAF7>; Tue, 31 Jul 2001 20:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269168AbRHAAFt>; Tue, 31 Jul 2001 20:05:49 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:58695 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S269140AbRHAAFe>;
	Tue, 31 Jul 2001 20:05:34 -0400
Message-ID: <20010801020539.A11083@win.tue.nl>
Date: Wed, 1 Aug 2001 02:05:39 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "Thomas Tanner" <tanner@ffii.org>, <linux-kernel@vger.kernel.org>
Subject: Re: harddisk suddenly locked?!
In-Reply-To: <MABBKEJEMCFLBEDCGCDNGEABCAAA.tanner@ffii.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <MABBKEJEMCFLBEDCGCDNGEABCAAA.tanner@ffii.org>; from Thomas Tanner on Tue, Jul 31, 2001 at 01:00:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 01:00:07PM +0200, Thomas Tanner wrote:

>  I can't access the data on my harddrive any longer ;-((
> 
>  The IBM Disk Fitness Test tool tells me:
>    Model                   : IBM-DJNA-372200
>    Microcode level         : J71OA30K
>    ATA Compliance          : ATA-4
>      Security feature      : Supported
>        Password            : Set
>        Password level      : High
>        Security mode       : Locked
> 
>  However, I haven't set any password. I don't even know how to set it!!
>  My system is (was) Linux 2.4.7 with PIIX support and "SCSI over IDE"
> enabled,
>  I wanted to start XWindows (4.01). However, it switched the video mode and
> suddenly locked up for ~10 sec. I pressed Ctrl-Alt-Backspace/Del
>  After some seconds it responded and seemed to shut down as usual.
>  Since then the hd is locked and I don't know why.

Better shield your monitor?

>  According to the ATA-3 specification

ATA-4 is also online.

>  To unlock a drive one has to send the command SECURITY UNLOCK (0xBB)
>  and transfer a single sector to the drive:

Maybe someone has already done it. Otherwise you'll have to play a little
with the code. It is easy. You could try to take setmax and hdparm as example
and add an ioctl that combines HDIO_DRIVE_TASK and HDIO_DRIVE_CMD.
