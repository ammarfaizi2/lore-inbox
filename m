Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267052AbUBEXhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267070AbUBEXhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:37:16 -0500
Received: from mail.convergence.de ([212.84.236.4]:32945 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267052AbUBEXhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:37:12 -0500
Date: Fri, 6 Feb 2004 00:39:34 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Mike Black <mblack@csi-inc.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hotswap IDE
Message-ID: <20040205233934.GC10450@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Mike Black <mblack@csi-inc.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <000701c3ebe6$ac5b35d0$c8de11cc@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c3ebe6$ac5b35d0$c8de11cc@black>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> I use a removable IDE chassis to allow me to mirror my primary drive for offsite storage.
> I'd like to hotswap the IDE but can't seem to get the drive to allow DMA access after restarting it.
> A reboot is necessary for DMA access.
> I'm using idectl from hdparm-5.4 which generates the following hdparm commands:
> /sbin/hdparm -U 1 /dev/hda
> /sbin/hdparm -R 0x170 0 0 /dev/hda

I haven't tried myself, but Alan Cox did:

Linux 2.4.22-rc2-ac3
 o       Finish off the core IDE hotplug support         (me)
         | If your hardware supports it you can now
         | hdparm -b0 /dev/hdc  change drive hdparm -b1 /dev/hdc

Maybe that works better than -U/-R ?

Johannes
