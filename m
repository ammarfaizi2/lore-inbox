Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWCKECt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWCKECt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWCKECt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:02:49 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16219 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932408AbWCKECs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:02:48 -0500
Date: Fri, 10 Mar 2006 19:19:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Memory barriers and spin_unlock safety
In-reply-to: <5NY0h-7wa-1@gated-at.bofh.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <441225B7.5010003@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Ml19-2Ki-19@gated-at.bofh.it> <5MlO0-3JU-13@gated-at.bofh.it>
 <5MCF0-2TS-27@gated-at.bofh.it> <5MITJ-2l4-15@gated-at.bofh.it>
 <5NXxl-6WZ-9@gated-at.bofh.it> <5NY0h-7wa-1@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Close, yes. HOWEVER, it's only really ordered wrt the "innermost" bus. I 
> don't think PCI bridges are supposed to post PIO writes, but a x86 CPU 
> basically won't stall for them forever. I _think_ they'll wait for it to 
> hit that external bus, though.

PCI I/O writes are allowed to be posted by the host bus bridge (not 
other bridges) according to the PCI 2.2 spec. Maybe no x86 platform 
actually does this, but it's allowed, so technically a device would need 
to do a read in order to ensure that I/O writes have arrived at the 
device as well.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


