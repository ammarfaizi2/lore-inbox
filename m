Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262752AbTCJIiY>; Mon, 10 Mar 2003 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262760AbTCJIiI>; Mon, 10 Mar 2003 03:38:08 -0500
Received: from AMarseille-201-1-1-111.abo.wanadoo.fr ([193.252.38.111]:13607
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262752AbTCJIgt>; Mon, 10 Mar 2003 03:36:49 -0500
Subject: Re: Problem with mmap( ) in linux ppc!
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anand Gurumurthy <anand@rttsindia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030310115059.2862dfb1.anand@rttsindia.com>
References: <20030310115059.2862dfb1.anand@rttsindia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047286101.19500.19.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Mar 2003 09:48:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 07:20, Anand Gurumurthy wrote:
> Hi,
> 	We have a driver for a communication card which has memory mapped IO
> We are using redhat 2.2.14 kernel on intel p3 processor. The driver has an
> mmap entry point to map device memory into the user space using remap_page_range().
> It works fine with intel P3. When we try to use the same driver with ppc linux 2.2.17
> kernel, the mmap system call does not map the proper device memory.Is there anything
> extra  required for using mmap with ppc? Please help me with your suggestions.

You may have some remapping going on the bus, it depends which PPC machine you
are using (how it's host bridge is confiured). 2.2 kernel didn't deal with
that as transparently as 2.4 do. Just a guess... I don't know much about
your HW

Ben.

