Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVANSQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVANSQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVANSQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:16:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:7072 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261278AbVANSPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:15:55 -0500
Date: Fri, 14 Jan 2005 10:15:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapspace layout improvements advocacy
Message-Id: <20050114101532.3a855a04.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de>
References: <20050112123524.GA12843@lnx-holt.americas.sgi.com>
	<Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain>
	<20050112105315.2ac21173.akpm@osdl.org>
	<Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>
> I recently found out that 2.6 kernels degrade horribly when going into 
>  swap. On my dual PIII-850 with as little as 256 mb ram, I can easily 
>  demonstrate that by opening about 40-50 instances of konquerer with large 
>  tables, many images and such things. When the machine is into 80-120 mb of 
>  the 256 mb swap partition, it becomes almost unusable. Even the desktop 
>  background picture needs ~20sec to update, not to talk about any windows' 
>  contents. And you can literally hear the reason for it: the harddisk is 
>  seeking like crazy.
> 
>  I've applied Ingo Molnars swapspace-layout-improvements-2.6.9-rc1-bk12-A1
>  port of the patch to a 2.6.11-rc1 kernel, and it handles the same workload 
>  much smoother. It's slow, but you can work with it.

Well I'm surprised.  I ran a couple of silly tests and wasn't able to
demonstrate any benefit.  But I didn't persist at all due to general inbox
overload :(

>  I just wonder why noone else complained yet.

They're all too polite?

> Are systems with tight memory constraints so uncommon these days?

Relatively, but I think we do have some fairly technical people on this
list who push their systems that hard, which is appreciated.  I'll add the
patch to the -mm lineup for a while..
