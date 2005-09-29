Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVI2TFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVI2TFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVI2TFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:05:10 -0400
Received: from main.gmane.org ([80.91.229.2]:2472 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932186AbVI2TFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:05:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wes Felter <wesley@felter.org>
Subject: Re: em64t speedstep technology not supported in kernel yet?
Date: Thu, 29 Sep 2005 13:58:18 -0500
Message-ID: <433C394A.7010802@felter.org>
References: <433C1787.4090001@watson.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
In-Reply-To: <433C1787.4090001@watson.wustl.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Wohlstadter wrote:
> Hello all,
> 
> We recently had Intel give our company a roadmap presentation where they 
> told us that their enhanced speedstep technology was supported by linux 
> kernels 2.6.9+.  I have since tried to get cpufreq speedstep driver to 
> work with no luck on our em64t Xeon 3.6g processors.  Intel even has a 
> webpage describing the technology and how to get it working at url: 
> http://www.intel.com/cd/ids/developer/asmo-na/eng/195910.htm?prn=Y

I think this is a BIOS problem; the BIOS needs to provide the proper 
ACPI frequency/voltage tables for cpufreq to use. You might want to 
harass your system/motherboard vendor.

Alternately maybe you can find someone who can give you the secret table 
and then you can just hardcode it into the driver.

> The only processor I have had luck with so far is a 32-bit Xeon with the 
> p4-clockmod driver(which does not appear to be present in the x86-64 
> kernel).

Beware that p4-clockmod won't increase the power efficiency of your 
system. (As an aside, clock modulation is so simple that you can do it 
from userspace in a few lines of C if you modprobe msr. This works on 
x86-64.)

Wes Felter - wesley@felter.org


