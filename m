Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUBEKqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUBEKqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:46:05 -0500
Received: from catv-5062a04e.szolcatv.broadband.hu ([80.98.160.78]:53126 "EHLO
	catv-5062a04e.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S263880AbUBEKqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:46:02 -0500
Message-ID: <40221EE7.6010904@freemail.hu>
Date: Thu, 05 Feb 2004 11:45:59 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu; rv:1.6) Gecko/20040115
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Fiene <ff@veka.com>
Subject: Re: USB mouse doesn't work since 2.6.2-rc3
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had the same problem, then I realized that at the same time
the machine's BogoMIPS fell like an apoplectic hawk.
(Bored of the Rings(TM))

Disable PM timer in the kernel config or use the
"clock=tsc" command line for the kernel. Or use a
later -mm kernel that has a fix in the pmtmr code
and use tsc for short delays. This can cause timing
inaccuracy on variable clocked CPUs.

> I have a Logitech Optical Trackman and it worked fine with versions < 
> 2.6.2-rc3.
> 
> The command "lsusb" shows me only the hubs but no connected USB gadget.
> Must i upgrade tools, libs, ... for the latest kernel?
> My system is a Thinkpad A31p with SuSE 9 and following usb rpms:
> usbutils-0.11-124
> libusb-0.1.8beta-35
> 
> I've tried 2.6.2-rc3 and 2.6.2-vanilla.
> 
> Please help.
> Regards, Frank.
> -- 

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.
