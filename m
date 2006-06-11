Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWFKKJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWFKKJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 06:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWFKKJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 06:09:30 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:63437 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751171AbWFKKJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 06:09:30 -0400
Date: Sun, 11 Jun 2006 12:09:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vishal Patil <vishpat@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: CSCAN vs CFQ I/O scheduler benchmark results
In-Reply-To: <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606111202370.13585@yvahk01.tjqt.qr>
References: <4745278c0606091230g1cff8514vc6ad154acb62e341@mail.gmail.com>
 <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The previous mail got scrambbled and hence I am resending this one
> again
>
Still. Here are the values, fit for 80 cols.

			Latency (seconds)
			CFQ	CSCAN
	seq reads	0.0116	0.0148
	seq writes	0.0164	0.0092
	seq r+w		0.0107	0.0169
	rnd reads	0.1178	0.1043
	rnd writes	0.0423	0.0473
	rnd r+w		0.0605	0.0732

			Throughput MB/sec
			CFQ	CSCAN
	seq reads	19.062	14.553
	seq writes	15.251	22.108
	seq r+w		22.127	14.72
	rnd reads	2.1197	2.394
	rnd writes	1.0032	0.9304
	rnd r+w		1.376	1.399

Excels at sequential writes, so it seems like a good idea to use CSCAN on a 
target drive when doing `rsync disk1/ disk2/`, esp. for large 
files.



Jan Engelhardt
-- 
