Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUC1UmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUC1UlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:41:23 -0500
Received: from ns.clanhk.org ([69.93.101.154]:50352 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262176AbUC1UkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:40:18 -0500
Message-ID: <4067383F.1030805@clanhk.org>
Date: Sun, 28 Mar 2004 14:40:31 -0600
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Status of the sata_sil driver for the VT8237
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com> <40664AE4.8010003@clanhk.org> <406680AB.8090204@stesmi.com> <4066833B.4080004@clanhk.org> <4067340A.5080709@pobox.com>
In-Reply-To: <4067340A.5080709@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Do you really plan to get 300MB/sec from two disks?  :)


Yes, for about 50-100ms at a time, and -to- the disks, not from them; 
well, the caches anyway.  On 133MB/s PCI, more like 150-300ms of 
saturation on bursts, and shared with the NICs.  I have very short and 
bursty I/O patterns as is typical in real-time applications.  It's 
easier to guarantee latency when your pipes are always at a small 
fraction of their potential.  100ms higher latency, even for part of a 
second, is quite noticeable in what I serve.

-ryan

PS 2.6 dropped my latencies under load by about 90% over 2.4!  We're 
talking 40-80ms application response time under high load to 8-10ms 
under high load.  <3
