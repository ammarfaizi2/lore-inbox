Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTH0V6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTH0V6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:58:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:32386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262267AbTH0V6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:58:16 -0400
Date: Wed, 27 Aug 2003 14:57:55 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binary kernel drivers re. hpt370 and redhat
Message-Id: <20030827145755.7e1ce956.shemminger@osdl.org>
In-Reply-To: <200308271840.30368.jbriggs@briggsmedia.com>
References: <200308271840.30368.jbriggs@briggsmedia.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 18:40:30 -0400
joe briggs <jbriggs@briggsmedia.com> wrote:

> I have a client who has a raid controller currently supported under windows, 
> and now wants to support linux as a bootable device.  Currently, some of 
> their trade secrets are contained in the driver as opposed to the controller 
> firmware, etc., so for now they wish to release a binary-only driver to 
> certain beta customers.  (i.e., 1st stage of porting is similar functionality 
> as windows). Am I correct that in order to boot off of this device that the 
> driver would have to be statically linked in vs. a module which could be 
> distributed as a binary-only driver keyed to the kernel.revision of the 
> distribution's kernel?  I would like to avoid any flames and ask that all 
> recognize that some hardware providers are having to ease into the pond a toe 
> at a time.  Any constructive thoughts, suggestions, references, tips, etc. 
> highly appreciated.

The driver could be a module and live in initramfs.  If you can
get the initial Linux image and initramfs loaded, you would be okay.

The problem is more in the bootloader (LILO or GRUB) would not no how
to do raid. The /boot partition would have to be on a non-raid partition.
Same problem if driver is statically linked in the kernel.
