Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWBMKVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWBMKVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWBMKVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:21:14 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:62481 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751717AbWBMKVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:21:13 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: 2.6.16-rc3, sata_nv PM resume, x86-64
Date: Mon, 13 Feb 2006 10:21:20 +0000
User-Agent: KMail/1.9.1
Cc: Andrew Chew <achew@nvidia.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131021.20507.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently been experimenting with S3 suspend on my Athlon 64 X2 3800+ 
system, on an nForce4 SLI CK804 mainboard. My machine will suspend-to-mem 
with the command:

echo mem >> /sys/power/state

And when I press the pwr button, it resumes correctly, even back into X11. 
However, things freeze shortly after.

I tracked down the problem to my SATA controller not being reinitialised 
properly on resume. I get an ata timeout message (which I apologise for not 
having handy, but the machine has no serial ports and vesafb is garbled by 
the suspend. If you really need this message I can probably find a way to get 
it).

I'm reporting this because I notice on the Jeff's Linux SATA status page, 
sata_nv is listed as having "full PM". Find my config and dmesg from a 
successful boot at:

http://devzero.co.uk/~alistair/oops-20060213/config
http://devzero.co.uk/~alistair/oops-20060213/dmesg

Ignore the directory title, I'm recycling these files from reporting a cpu 
hotplug oops last night.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
