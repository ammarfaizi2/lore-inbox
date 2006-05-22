Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWEVC3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWEVC3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 22:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWEVC3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 22:29:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932427AbWEVC3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 22:29:14 -0400
Date: Sun, 21 May 2006 22:29:12 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: edac driver names in sysfs.
Message-ID: <20060522022912.GS8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EDAC does something funky that no other afaik seems to do.

#define edac_xstr(s) edac_str(s)
#define edac_str(s) #s
#define EDAC_MOD_STR edac_xstr(KBUILD_BASENAME)

And then..

	.name = EDAC_MOD_STR,

in its pci_driver structs.
This leads to it looking a bit 'odd' in /sys/bus/pci/drivers
compared to the others.

/sys/bus/pci/drivers/\"e752x_edac\"/

Is correcting this to remove the quotes likely to break anything
in userspace ?

		Dave

-- 
http://www.codemonkey.org.uk
