Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264642AbSJOTFg>; Tue, 15 Oct 2002 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264660AbSJOTFf>; Tue, 15 Oct 2002 15:05:35 -0400
Received: from [203.117.131.12] ([203.117.131.12]:20101 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264642AbSJOTFe>; Tue, 15 Oct 2002 15:05:34 -0400
Message-ID: <3DAC685B.9070102@metaparadigm.com>
Date: Wed, 16 Oct 2002 03:11:23 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Steven Dake <sdake@mvista.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/02 01:38, Steven Dake wrote:

> At this point, there isn't anything using them.  I am working on a 
> hotswap manager, that may be in kernel space (for performance reasons) 
> that may use these interfaces.  I'm also working on a SAFTE Hotswap 
> processor module (ie; drivers/scsi/sp.c) for the SCSI subsystem that 
> uses these interfaces.  (Safte is a hotswap standard for SCSI chassis).

Do you really want to have SAF-TE polling in the kernel?

This can easily be accomplished in userspace using sg.

safte-monitor <http://gort.metaparadigm.com/safte-monitor/> can already
provde disk insertion, removal notifications in userspace and already
supports calling out to a script with the physical slot location information
(and with tweaks to the code, scsi device of the disk inserted)

There is even code in safte-monitor to identify the wwn of the devices
in each slot, although it needs updating to the latest qlogic ioctl
interface (or hbaapi).

~mc

