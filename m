Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbVJSGAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbVJSGAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 02:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbVJSGAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 02:00:12 -0400
Received: from ns1.mcdownloads.com ([216.239.132.98]:54718 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S1751518AbVJSGAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 02:00:10 -0400
Subject: Re: 2.6.14-rc4-mm1: udev/sysfs wierdness
From: Aaron Gyes <floam@sh.nu>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Segaud <matt@regala.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <20051019034427.GA15940@kroah.com>
References: <1129610113.10504.4.camel@localhost>
	 <20051018055003.GA10488@kroah.com> <20051018065705.GA11858@kroah.com>
	 <87r7ajdy4v.fsf@barad-dur.minas-morgul.org>
	 <20051019034427.GA15940@kroah.com>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 23:00:08 -0700
Message-Id: <1129701608.10192.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 20:44 -0700, Greg KH wrote:
> I was against my latest tree, which is on kernel.org.  Someone already
> posted an updated patch on lkml if you can't get that second hunk to
> apply.

I applied that, and I still don't see the node being created. 

Here's the udevinfo output you originally asked for:

floam@agorastome ~ $ udevinfo -p /sys/class/input/event0/ -a

udevinfo starts with the device the node belongs to and then walks up
the
device chain, to print for every device found, all possibly useful
attributes
in the udev key format.
Only attributes within one device section may be used together in one
rule,
to match the device for which the node will be created.

device '/sys/class/input/event0' has major:minor 13:64
  looking at class device '/sys/class/input/event0':
    KERNEL=="event0"
    SUBSYSTEM=="input"
    SYSFS{dev}=="13:64"


