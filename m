Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVE1DYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVE1DYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVE1DYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:24:38 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:39554 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261343AbVE1DYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:24:35 -0400
Message-ID: <4297E475.3040906@comcast.net>
Date: Fri, 27 May 2005 23:24:37 -0400
From: John Livingston <jujutama@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to find if BIOS has already enabled the device
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com> <200505272150.15109.kernel-stuff@comcast.net>
In-Reply-To: <200505272150.15109.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>The offending code is in hcd-pci.c - which 
>seems to be executed unconditionally. usb_hcd_pci_probe() calls 
>pci_enable_device() which hangs if there was already a device present, 
>attached to the controller. 
>  
>
Have you attempted more generic fix-hardware-hang solutions?  I've known 
more than a few times where a good old "noapic nolapic" snapped a box 
out of some strange and seemingly unrelated problems...

Also, is your BIOS fully up to date/modern?  A quick Google search found 
a few things like this:
http://www.techspot.com/vb/all/windows/t-18940-USB-Hub-And-Boot-Problems.html
The problem might be more generic than a bad interaction between drive 
and kernel.

~John Livingston
