Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWJENVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWJENVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWJENVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:21:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:40312 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750788AbWJENVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:21:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iePB413c8qH1TqW3YJ0TglEA9ydSeFQI8o14lzBSFlywi1nb1bHpa6M1OVZvOkY/73rS/B7716clQp4+MhDADwKOd9Yio5QfrWwccIizUQEwkH5TuUc0F5t7yw021RLXVrwCpHn+y56qgKPytjV2G4Ca85W5iQesREyE97dHwSw=
Message-ID: <4525070D.9030609@gmail.com>
Date: Thu, 05 Oct 2006 07:22:21 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Christer Weinigel <christer@weinigel.se>
Subject: Re: [patch 2.6.18+] MAINTAINERS - take over scx200-* and pc8736*
 drivers
References: <45248867.40903@gmail.com> <20061005105351.f791f4f1.khali@linux-fr.org>
In-Reply-To: <20061005105351.f791f4f1.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add MAINTAINERS entries for new scx200_hrt and pc8736x_gpio drivers, and 
take over maintenance of scx200_gpio, authored by Christer Weinigel 
(which Ive hacked at), who no longer has the hardware.
Also take over hwmon/pc87360, authored by Jean Delvare, who's dropped 
maintenance to dedicate more time to hwmon subsystem.


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
---

Christer acked this off-list already, in case he's too busy and misses 
this one.

$ diffstat diff.maintainers
 MAINTAINERS |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)



Jean Delvare wrote:
> Yep, I'm fine with Jim taking over maintainerchip of the pc87360
> hardware monitoring driver.
>
>   

>> +NSC_GPIO Common Methods Module (supports PC8736x_GPIO and SCX200_GPIO Drivers)
>>     
>
> All other entries in this file are uppercase.
>
> I also doubt that anyone will ever search for "common methods module",
> I'm not even sure I understand what it means. What's really important
> here are the driver names IMHO, and you already have added entries for
> these below - isn't that sufficient?
>
>   
Ack.  I was ambivalent about this, since its not a driver, and nobody 
would modprobe it directly.
I went for thoroughness, assuming Id be corrected.. ;-)


diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.18/MAINTAINERS doc-touches/MAINTAINERS
--- linux-2.6.18/MAINTAINERS	2006-09-19 23:57:12.000000000 -0600
+++ doc-touches/MAINTAINERS	2006-10-05 07:03:45.000000000 -0600
@@ -2215,6 +2215,17 @@ T:	git kernel.org:/pub/scm/linux/kernel/
 T:	cvs cvs.parisc-linux.org:/var/cvs/linux-2.6
 S:	Maintained
 
+PC87360 HARDWARE MONITORING DRIVER
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
+PC8736x GPIO DRIVER
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Maintained
+
 PCI ERROR RECOVERY
 P:	Linas Vepstas
 M:	linas@austin.ibm.com
@@ -2525,10 +2536,19 @@ L: lksctp-developers@lists.sourceforge.n
 S: Supported
 
 SCx200 CPU SUPPORT
-P:	Christer Weinigel
-M:	christer@weinigel.se
-W:	http://www.weinigel.se
-S:	Supported
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Odd Fixes
+
+SCx200 GPIO DRIVER
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Maintained
+
+SCx200 HRT CLOCKSOURCE DRIVER
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Maintained
 
 SECURITY CONTACT
 P:	Security Officers


