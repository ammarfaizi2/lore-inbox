Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271364AbTGQIci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271365AbTGQIci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:32:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3086 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271364AbTGQIch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:32:37 -0400
Date: Thu, 17 Jul 2003 10:47:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Joel Becker <Joel.Becker@oracle.com>
cc: Andrew Morton <akpm@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
In-Reply-To: <20030717082716.GA19891@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0307171037070.717-100000@serv>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org>
 <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org>
 <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org>
 <20030716222015.GB1964@win.tue.nl> <20030716152143.6ab7d7d3.akpm@osdl.org>
 <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org>
 <20030717082716.GA19891@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Jul 2003, Joel Becker wrote:

> On Wed, Jul 16, 2003 at 04:49:17PM -0700, Andrew Morton wrote:
> > Please describe a scenario in which a filesystem which works on current
> > kernels will, in a 64-bit-dev_t kernel, call init_special_inode() with a
> > 16:16 encoded device number.
> 
> 	Perhaps he's thinking of NFSv2.  If you want to make a device
> bigger than 8:8...  Personally, I'm happy to ignore NFSv2 for this.

It's not just NFS2, with NFS3 and later it also depends on how many and 
which bits the server keeps. They usually use the standard major/minor/ 
makedev macros, so you only get back what the platform supports.
Splitting dev_t in major/minor numbers can be lots of fun...

bye, Roman

