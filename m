Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTL1TCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 14:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTL1TCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 14:02:11 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:60566 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S261892AbTL1TCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 14:02:09 -0500
Date: Sun, 28 Dec 2003 10:50:00 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
In-Reply-To: <20031228180424.GA16622@mail-infomine.ucr.edu>
Message-ID: <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well if you currently have 1tb in 8 non-redundant drives then you using 
160GB disks... no?

the biggest p-ata disks right now are ~320GB so you can do a ~1TB software 
raid 5 stripe on a single 4 port ata controller such as a promise tx4000 
using regular software raid rather than the promise raid. that would end 
up being fairly inexpensive and buy you more protection.

linux software raid hsa been as releiable as anything else we've used over 
the years, the lack of reliabilitiy in your situation will come entirely 
from failing disks, lose one and your filesystem is toast.

joelja

On Sun, 28 Dec 2003, Johannes Ruscheinski wrote:

> Hi,
> 
> We're looking for a low-cost high-reliability IDE RAID solution that works well
> with the 2.6.x series of kernels.  We have about 1 TB (8 disks) that we'd
> like to access in a non-redundant raid mode.  Yes, I know, that lack of
> redundancy and high reliability are contradictory.  Let's just say that
> currently we lack the funding to do anything else but we may be able to obtain
> more funding for our disk storage needs in the near future.
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


