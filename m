Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVBIAPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVBIAPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVBIAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:15:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:2003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261710AbVBIAPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:15:33 -0500
Date: Tue, 8 Feb 2005 16:15:30 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Subject: Re: [PATCH] New sys_chmod() hook for the LSM framework
Message-ID: <20050208161530.F469@build.pdx.osdl.net>
References: <1107879275.3754.279.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1107879275.3754.279.camel@localhost.localdomain>; from lorenzo@gnu.org on Tue, Feb 08, 2005 at 05:14:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Hernández García-Hierro (lorenzo@gnu.org) wrote:
> As commented yesterday, I was going to release a few more hooks for some
> *critical* syscalls, this one adds a hook to sys_chmod(), and makes us
> able to apply checks and logics before releasing the operation to
> sys_chmod().

This is exactly the kind of hook we've tried to avoid.  This is really
asking for permission to alter inode attribute data.  This type of
hook is incomplete because there are other ways to alter this data,
and this access is already controlled by the inode_setattr hook (as
Tony mentioned).  So this is a no go.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
