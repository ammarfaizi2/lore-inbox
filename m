Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUGPJRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUGPJRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUGPJQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:16:50 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:48079 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266508AbUGPJQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:16:36 -0400
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
In-Reply-To: <87oemhot7l.fsf@deneb.enyo.de>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <87oemhot7l.fsf@deneb.enyo.de>
Message-Id: <E1BlOpX-0005AW-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Fri, 16 Jul 2004 10:16:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:

>  - After terminating the X11 server, other devices on the sharded IRQ
>    11 are dead (most prominently, e1000 and USB).

Try the last proposed patch along with the ACPI_NOT_ISR patch from
http://bugzilla.kernel.org/show_bug.cgi?id=2643 and see if it makes any
difference. Without the sysfs support, the 8259 never gets set for level
triggering on resume.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
