Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSGLElX>; Fri, 12 Jul 2002 00:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317675AbSGLElX>; Fri, 12 Jul 2002 00:41:23 -0400
Received: from codepoet.org ([166.70.99.138]:49595 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317648AbSGLElW>;
	Fri, 12 Jul 2002 00:41:22 -0400
Date: Thu, 11 Jul 2002 22:44:13 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020712044413.GA2436@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <agl7ov$p91$1@cesium.transmeta.com> <20020712041320.GA2046@codepoet.org> <3D2E585F.2010302@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2E585F.2010302@zytor.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jul 11, 2002 at 09:17:35PM -0700, H. Peter Anvin wrote:
> Erik Andersen wrote:
> >On Thu Jul 11, 2002 at 05:27:11PM -0700, H. Peter Anvin wrote:
> >
> >>Okay, I have suggested this before, and I haven't quite looked at this
> >>in detail, but I would again like to consider the following,
> >>especially given the changes in 2.5:
> >>
> >>Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> >>and treat all ATAPI devices as what they really are -- SCSI over IDE.
> >>It is a source of no ending confusion that a Linux system will not
> >>write CDs to an IDE CD-writer out of the box, for the simple reason
> >>that cdrecord needs access to the generic packet interface, which is
> >>only available in the nonstandard ide-scsi configuration.
> >
> >
> >cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
> >work regardless,
> >
> 
> Lovely.  Let's make EACH APPLICATION support two disjoint APIs for no 
> good reason.

Lovely.  Lets rip off a sarcastic answer without spending two
seconds to think.  Why would anybody need to support two APIs?  
The existing CDROM_SEND_PACKET ioctl is an ATAPI/SCSI pass
through interface, and is sufficient to operate both IDE and 
SCSI cd writers.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
