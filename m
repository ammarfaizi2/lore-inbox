Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313392AbSDJSDv>; Wed, 10 Apr 2002 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313409AbSDJSDu>; Wed, 10 Apr 2002 14:03:50 -0400
Received: from air-2.osdl.org ([65.201.151.6]:39436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313392AbSDJSDt>;
	Wed, 10 Apr 2002 14:03:49 -0400
Date: Wed, 10 Apr 2002 11:00:49 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7 and runaway modprobe loop? 
In-Reply-To: <4002.1018421508@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33L2.0204101059130.25409-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Keith Owens wrote:

| On Tue, 9 Apr 2002 09:17:08 -0700 (PDT),
| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >If I build/boot 2.5.7 with 64 GB support (with or without
| >high_pte), I get:
| >
| >Freeing unused kernel memory: 448k freed
| >INIT: version 2.78 booting
| >kmod: runaway modprobe loop assumed and stopped
| >kmod: runaway modprobe loop assumed and stopped
| >kmod: runaway modprobe loop assumed and stopped
| >kmod: runaway modprobe loop assumed and stopped
| >kmod: runaway modprobe loop assumed and stopped
| >
| >If I build/boot it with 4 GB support, it boots fine.
| >
| >Fixes, suggestion?
|
| If /var/log/ksymoops exists and is mounted rw when that message is
| issued, look at 20020409.log to see what modprobe is asking for.
| Otherwise add a printk to kernel/kmod::request_module() to print
| module_name.  In either case, work out why it is going recursive.

Thanks for replying, Keith.

I added module_name to the runaway message (OK ?) and its
answer is binfmt-0000.

I also moved from 2.5.7 to 2.5.8-pre2 and don't have this
problem.

-- 
~Randy

