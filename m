Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUI3DHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUI3DHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 23:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUI3DHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 23:07:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:22433 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268045AbUI3DHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 23:07:21 -0400
Date: Wed, 29 Sep 2004 20:05:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: akpm@osdl.org, ttb@tentacle.dhs.org, ray-lk@madrabbit.org,
       cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040929200525.4e7bb489.pj@sgi.com>
In-Reply-To: <1096508073.16832.17.camel@localhost>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
	<1096350328.26742.52.camel@orca.madrabbit.org>
	<20040928120830.7c5c10be.akpm@osdl.org>
	<41599456.6040102@nortelnetworks.com>
	<1096390398.4911.30.camel@betsy.boston.ximian.com>
	<1096392771.26742.96.camel@orca.madrabbit.org>
	<1096403685.30123.14.camel@vertex>
	<20040929211533.5e62988a.akpm@osdl.org>
	<1096508073.16832.17.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:
> A monitor on "/etc" will return "hosts" if hosts is modified.  Which I
> think is OK--we don't pass the entire path, nor do we want to if we
> could do it easily, for numerous reasons ..

How about returning the inode number?

Notice that this can be converted to the name without using stat, using
the d_ino field in the struct dirent returned from an opendir/readdir
loop.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
