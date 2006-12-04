Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758769AbWLDHgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758769AbWLDHgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 02:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758795AbWLDHgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 02:36:18 -0500
Received: from quechua.inka.de ([193.197.184.2]:15241 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1758769AbWLDHgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 02:36:17 -0500
Message-ID: <4573CFBB.1030107@dungeon.inka.de>
Date: Mon, 04 Dec 2006 08:35:23 +0100
From: Andreas Jellinghaus <aj@dungeon.inka.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: sergio@sergiomb.no-ip.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.19 still crashing
References: <4571AFED.8060200@dungeon.inka.de> <1165200588.9189.1.camel@monteirov>
In-Reply-To: <1165200588.9189.1.camel@monteirov>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Ciphire-Security: plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> Hi,
> 1st you should put this information on http://bugzilla.kernel.org/

ok, thanks.

> your bug kept me the attention because on bad interrupts  you have :
> 
> 21:     100000   IO-APIC-fasteoi   ohci1394
> 
> Exactly oops on 100000 interrupts, I had seen this before .
> I have my bug on http://bugzilla.kernel.org/show_bug.cgi?id=6419
> which one of the bugs looks like similar to yours. 
> 
> So, You are saying with kernel 2.6.16.31 with xen 3.0.2, you don't have
> this problem , I like to try it, how or where you build this Xenified
> kernel ? 

The package source were available at , but they no longer are :(
http://debian.thoughtcrime.co.nz/ubuntu/

I can send you my copies (either parts or all), if you don't mind
getting big emails
-rw-r--r--  1 aj aj  342068 2006-04-19 12:14 libxen3.0_3.0.2-2r7_amd64.deb
-rw-r--r--  1 aj aj  106440 2006-04-19 12:14 libxen-dev_3.0.2-2r7_amd64.deb
-rw-r--r--  1 aj aj  155186 2006-04-19 12:14 
libxen-python_3.0.2-2r7_amd64.deb
-rw-r--r--  1 aj aj  620946 2006-04-19 12:14 
linux-patch-xen_3.0.2-2r7_amd64.deb
drwxr-xr-x 10 aj aj    4096 2006-04-19 12:14 xen-3.0.2
-rw-r--r--  1 aj aj   12926 2006-04-19 12:14 xen_3.0.2-2r7_amd64.deb
-rw-r--r--  1 aj aj  656745 2006-04-19 12:12 xen_3.0.2-2r7.diff.gz
-rw-r--r--  1 aj aj     645 2006-04-19 12:12 xen_3.0.2-2r7.dsc
-rw-r--r--  1 aj aj       0 2006-04-19 12:14 xen_3.0.2-2r7.dsc.asc
-rw-r--r--  1 aj aj 4933621 2006-04-19 11:36 xen_3.0.2.orig.tar.gz
-rw-r--r--  1 aj aj  531232 2006-04-19 12:14 xen-docs_3.0.2-2r7_all.deb
-rw-r--r--  1 aj aj 1479866 2006-04-19 12:14 
xen-hypervisor-3.0_3.0.2-2r7_amd64.deb
-rw-r--r--  1 aj aj  180526 2006-04-19 12:14 
xen-utils-3.0_3.0.2-2r7_amd64.deb

only *dsc *diff.gz and *orig.tar.gz are needed, then you can recompile
the rest yourself ("dpkg-source -x *dsc; cd xen-*/; dpkg-buildpackage 
-rfakeroot").

or I can send you the kernel patch as file and the xen hypervisor:
-rw-r--r-- 1 root root  244694 2006-04-19 12:14 /boot/xen-3.0.2-2.gz
-rw-r--r-- 1 root root  604942 2006-04-19 12:14 
/usr/src/kernel-patches/diffs/xen/linux-2.6.16-xen.patch.gz

it applies clean against 2.6.16, but if with 2.6.16.31 I had
to manually fix two rejects.

Regards, Andreas
