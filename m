Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUIHQbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUIHQbP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIHQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:30:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48607 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268698AbUIHQae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:30:34 -0400
Subject: Re: Major XFS problems...
From: Greg Banks <gnb@melbourne.sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040908154434.GE390@unthought.net>
References: <20040908123524.GZ390@unthought.net>
	 <322909db040908080456c9f291@mail.gmail.com>
	 <20040908154434.GE390@unthought.net>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094661418.19981.36.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 09 Sep 2004 02:36:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 01:44, Jakob Oestergaard wrote:
> SMP systems on 2.6 have a problem with XFS+NFS.

Knfsd threads in 2.6 are no longer serialised by the BKL, and the
change has exposed a number of SMP issues in the dcache.  Try the
two patches at

http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2

and

http://linus.bkbits.net:8080/linux-2.5/cset@1.1722.48.23

(the latter is in recent Linus kernels).  If you're still having
problems after applying those patches, Nathan and I need to know.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


