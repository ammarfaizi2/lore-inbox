Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVKVI0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVKVI0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVKVI0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:26:43 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:35233 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750919AbVKVI0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:26:42 -0500
Date: Tue, 22 Nov 2005 09:29:47 +0100
To: Lars Roland <lroland@gmail.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
Message-ID: <20051122082947.GA10890@aitel.hist.no>
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 09:31:14PM +0100, Lars Roland wrote:
> I have created a stripe across two 500Gb disks located on separate IDE
> channels using:
> 
> mdadm -Cv /dev/md0 -c32 -n2 -l0 /dev/hdb /dev/hdd
> 
> the performance is awful on both kernel 2.6.12.5 and 2.6.14.2 (even
> with hdparm and blockdev tuning), both bonnie++ and hdparm (included
> below) shows a single disk operating faster than the stripe:
> 
To rule out hardware problems (harware not as parallel as you might think):

Try running the performance test (bonnie++ or hdparm)
on both /dev/hdb and /dev/hdd at the same time. 

Two hdparms on different disks should not take longer time than one,
unless you have bad hardware.

One bonnie with size x MB takes y minutes to run.
Two bonnies, each of size x/2 MB should take between
y/2 an y minutes to run. If they need more, then something
is wrong again, explaining bad RAID performance.

Helge Hafting


