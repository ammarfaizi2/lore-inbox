Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbSI0TwC>; Fri, 27 Sep 2002 15:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbSI0TwC>; Fri, 27 Sep 2002 15:52:02 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:5112 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262622AbSI0TwA>; Fri, 27 Sep 2002 15:52:00 -0400
Subject: Re: [patch] 'virtual => physical page mappingcache',vcache-2.5.38-B8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D94B0BE.991E770@digeo.com>
References: <3D94A4D9.D458D453@digeo.com>
	<1033154186.16726.17.camel@irongate.swansea.linux.org.uk> 
	<3D94B0BE.991E770@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 21:02:49 +0100
Message-Id: <1033156969.16758.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Interesting. So now I have a new question to resolve, which is
> > why doing O_DIRECT and truncate together corrupted my disk when I tried
> > it trying to break stuff
> 
> Interesting indeed.  Possibly invalidate_inode_pages2() accidentally
> left some dirty buffers detached from the mapping.  Hard to see how
> it could do that.
> 
> What kernel were you testing?

2.4.20pre5-ac with new IDE. So there are several other candidates 8)

