Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUBKBp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUBKBp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:45:28 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:34949 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261744AbUBKBpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:45:23 -0500
Message-ID: <4029892C.2070009@backtobasicsmgmt.com>
Date: Tue, 10 Feb 2004 18:45:16 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATARAID userspace configuration tool
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk> <1076425115.23946.18.camel@leto.cs.pocnet.net> <40292246.2030902@backtobasicsmgmt.com> <1076440714.27328.8.camel@leto.cs.pocnet.net> <20040211013551.GB2153@kroah.com>
In-Reply-To: <20040211013551.GB2153@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> I really don't think udev in and of itself needs to know anything
> special about these kinds of devices, as it will be glad to kick off
> other programs for you if you want it to.

Agreed (not that I'm implementing any of this stuff :-)

The tricky part is for Thomas' ataraid-detect program to keep some 
information around when it has seen the first component of a RAID-0 but 
not the second (or vice-versa). It would be very inefficient to scan all 
known block devices every time a new one is added, although that 
brute-force method could be used just to get the program working at 
first. Once the whole idea has been tested and works properly (the 
ATARAID devices become available and function properly), the efficiency 
problem(s) could be addressed.

