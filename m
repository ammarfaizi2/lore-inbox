Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286193AbRLTHdK>; Thu, 20 Dec 2001 02:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286195AbRLTHdB>; Thu, 20 Dec 2001 02:33:01 -0500
Received: from white.pocketinet.com ([12.17.167.5]:15585 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S286193AbRLTHct>; Thu, 20 Dec 2001 02:32:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Willem Riede <wriede@home.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Tape driver rationalization for Linux 2.5?
Date: Wed, 19 Dec 2001 23:24:05 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011219172929.A23227@linnie.riede.org>
In-Reply-To: <20011219172929.A23227@linnie.riede.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEnRMWuLn5U9T3TG00000294@white.pocketinet.com>
X-OriginalArrivalTime: 20 Dec 2001 07:31:09.0032 (UTC) FILETIME=[4AD5FE80:01C18928]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 02:29 pm, Willem Riede wrote:
> Folks,
>
> Being the maintainer of the driver for Onstream tape drives (osst)
> and wanting to stay abreast with the kernel evolution, I've been
> reading up on some of the changes that are being made to the scsi
> sub-system in the 2.5.x kernel series, and that has got me
> thinking...
>
> I've never really understood why there are separate high level
> drivers for tape drives -- or cdroms for that matter (other than "it
> just happened that way").
>
> Also, I find the fact that the user needs to tell the kernel at boot
> time whether (s)he is going to use ide-scsi or not awkward. You
> should be able to point any appropriate driver to a device by loading
> the corresponding module (and maybe tell the module specifically not
> to touch some compatible device, but preferably just gracefully
> shared and locked (think sg)).
>
> I'm not alone here, quoting Linus from the Scheduler thread:
>    'And even more important than performance is being able to read
> and write to CD-RW disks without having to know about things like
> "ide-scsi" etc, and do it sanely over different bus architectures
> etc.'


Am I alone in knowing that, at least as of 2.4.9 (the earliest I'm 
really sure I used it on) through 2.4.16, you DON'T need any weird 
boot-time switches?
Simply DO NOT compile in the IDE CD-ROM drive, compile in SCSI CD-ROM 
and SCSI Generic support, and voila, fully functional ATAPI CD writer
this even works on my IDE DVD drive
to read from em, I just use /dev/scd#
I am using NO boot time flags, including ide-scsi
