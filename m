Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUGGPzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUGGPzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUGGPzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:55:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265060AbUGGPzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:55:09 -0400
Date: Wed, 7 Jul 2004 12:21:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Creation of driver-specific sysfs attributes
Message-ID: <20040707152106.GB2168@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, others,

Hope this is not a FAQ.

I want to export some read-only attributes (statistics) from cyclades.c char 
driver to userspace via sysfs. 

I can't figure out the right place to do it - I could create a class under
/sys/class/cyclades for example, but that doesnt sound right since this 
is not a "class" of device, but a device itself.

Hooking the statistics into /sys/class/tty/ttyC$/ sounds reasonable, but
its not possible it seems because "tty" is a class_simple class, which only implements 
the "dev" attribute.

What is the appropriate place for such driver-specific attributes?

TIA

