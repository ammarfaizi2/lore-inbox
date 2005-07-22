Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVGVIvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVGVIvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVGVIvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:51:14 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:42061 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262070AbVGVIvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:51:13 -0400
X-IronPort-AV: i="3.95,134,1120460400"; 
   d="scan'208"; a="650121520:sNHT27039744"
Message-ID: <42E0B367.2060702@cisco.com>
Date: Fri, 22 Jul 2005 18:50:47 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Andrew Morton <akpm@osdl.org>, bert hubert <bert.hubert@netherlabs.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: fastboot, diskstat
References: <20050722034135.GA21201@outpost.ds9a.nl> <20050722144710.47e0cbd6.akpm@osdl.org> <42E09DC1.90602@argo.co.il>
In-Reply-To: <42E09DC1.90602@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:

> parallelized initscripts will probably defeat this, though.
>
put all run-once-but-never-run-again scripts into initrd / initramfs?  
<evil grin>
boot into a suspend-to-disk image?

i still see the real solution at least for "desktop" machines is to 
minimize the sheer amount of stuff loaded in the rc scripts.
at least for my use-every-day laptop (IBM T42), i've literally halved 
the startup time by being savvy about what services are started and in 
many cases not starting things until a few minutes after i've logged in.

for example, making use of NetworkManager sorts out a lot of the delay 
associated with dhcp and roaming WiFi connections - so there are no 
start-on-boot network kruft.
likewise, as a desktop its completely academic if sendmail starts at T+0 
seconds or T+2 minutes.
same for sshd/cups/httpd/ntpd et al.

of what does run, you CAN run it in parallel & hopefully get some sense 
out of the elevator being intelligent.


cheers,

lincoln.
