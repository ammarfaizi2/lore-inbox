Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269247AbUI3MqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269247AbUI3MqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 08:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUI3MqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 08:46:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28578 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269247AbUI3MqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 08:46:08 -0400
Date: Thu, 30 Sep 2004 05:43:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: rml@novell.com, akpm@osdl.org, ttb@tentacle.dhs.org, ray-lk@madrabbit.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040930054354.09acc954.pj@sgi.com>
In-Reply-To: <415B9BB7.6070801@nortelnetworks.com>
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
	<20040929200525.4e7bb489.pj@sgi.com>
	<415B9BB7.6070801@nortelnetworks.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris replied to pj:
> > How about returning the inode number?
> 
> Then I think you need the filesystem as well.

They already had that, with the integer cookie representing the
directory ("/etc", in the example), as was a bit obvious, or else
returning the relative path ("hosts" in the example) wouldn't have
worked either.

That is, I was suggesting returning:

	{cookie-of-/etc,EVENT_MODIFY,inode-number-of-hosts-file}

instead of:

	{cookie-of-/etc,EVENT_MODIFY,"hosts"}

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
