Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVCEK7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVCEK7n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 05:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVCEK7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 05:59:43 -0500
Received: from mailfe02.swip.net ([212.247.154.33]:2019 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263050AbVCEK7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 05:59:02 -0500
X-T2-Posting-ID: qbtQLYJOjB4bCHCkpZ9cyM8vUUrdS/3cLdfSShO5ydk=
Message-ID: <42299184.2040205@laposte.net>
Date: Sat, 05 Mar 2005 12:01:24 +0100
From: Barbara Post <b.post@laposte.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ohci_hcd, usb scanner and kernel 2.6.8.1 or 2.6.10 troubles
References: <420D3EEF.20406@laposte.net> <420D455D.7050505@kernelpanic.ru>
In-Reply-To: <420D455D.7050505@kernelpanic.ru>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I finally succeeded in making my USB scanner work with 2.6.8.1 and above kernels. I remind you I was 
able to see connection/disconnection messages, but not to use it via xsane.

I found the solution on a Debian mailing-list, that worked for me :

cd to /dev
type :
/sbin/MAKEDEV usb

This command created the required character devices. Since USB support has been rewritten between 
2.6.7 and 2.6.8.1 kernels, this was likely to happen when one manually installs a new kernel...

Barbara

Boris B. Zhmurov wrote:
> 
> Hello, Barbara Post.
> 
> On 12.02.2005 02:25 you said the following:
> 
> | Hi,
> | I am unable to use my USB Agfa Snapscan 1212_U scanner, with kernel
> | 2.6.8.1 or 2.6.10 (both compiled by myself from www.kernel.org sources)
> | and xsane 0.96-1 (Debian).
> |
> | It worked with kernel 2.6.7.
> |
> | When I use VMware, I'm able to use it though (in Windows), whatever
> | linux kernel I use.
> |
> | When I start xsane, I get "error opening device
> | 'snapscan:libusb:001:004': I/O error on device" or simply "no device
> | found" if I restart xsane after the first error message (or sometimes at
> | first start).
> |
> | Sometimes it gets further and when I try to acquire preview, I get "I/O
> | error" and the following in /var/log/syslog :
> |
> | Feb 11 23:19:00 babs1 kernel: ohci_hcd 0000:00:02.2: urb c15e13e0 path
> | 1.3 ep1in 82160000 cc 8 --> status -75
> 
> 
> I have the same problem with my Epson 1260 on RHEL4 beta2 (linux-2.6.9).
> I don't know about 2.6.7, but with 2.4.21 (RHEL3) it works fine.
> 
> 
