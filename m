Return-Path: <linux-kernel-owner+w=401wt.eu-S932909AbWLSTPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbWLSTPl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbWLSTPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:15:41 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:56676 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909AbWLSTPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:15:40 -0500
X-Greylist: delayed 1380 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 14:15:40 EST
Date: Tue, 19 Dec 2006 18:52:23 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, gregkh@suse.de
Message-ID: <20061219185223.GA13256@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Changes to sysfs PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 047bda36150d11422b2c7bacca1df324c909c0b3 broke userspace. 
Previously, /sys/bus/pci/devices/foo/power/state could have values 
echoed into it for triggering suspend/resume calls in the driver. The 
breakage is handily mentioned in the comment:

"Devices with bus.suspend_late(), or bus.resume_early() methods fail 
this operation; those methods couldn't be called."

but there's no mention of what previously working code is supposed to do 
now. That's the second time in the past year or so that this interface 
has been broken - can we have it working again, please, especially as 
there doesn't appear to be an alternative yet?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
