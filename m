Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVBQNAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVBQNAz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVBQNAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:00:55 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:53956 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262141AbVBQNAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:00:51 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Date: Thu, 17 Feb 2005 08:00:27 -0500
User-Agent: KMail/1.7.92
Cc: noel@zhtwn.com, torvalds@osdl.org, kas@fi.muni.cz, axboe@suse.de,
       linux-kernel@vger.kernel.org
References: <20050121161959.GO3922@fi.muni.cz> <200502160107.08039.kernel-stuff@comcast.net> <20050216155255.0ffab555.akpm@osdl.org>
In-Reply-To: <20050216155255.0ffab555.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502170800.28012.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 06:52 pm, Andrew Morton wrote:
> So it's probably an ndiswrapper bug?
Andrew, 
It looks like it is a kernel bug triggered by NdisWrapper. Without 
NdisWrapper, and with just 8139too plus some light network activity the 
size-64 grew from ~ 1100 to 4500 overnight. Is this normal? I will keep it 
running to see where it goes.

A question - is it safe to assume it is  a kmalloc based leak? (I am thinking 
of tracking it down by using kprobes to insert a probe into __kmalloc and 
record the stack to see what is causing so many allocations.)

Thanks
Parag
