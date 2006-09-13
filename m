Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWIMBck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWIMBck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWIMBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:32:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37514 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030471AbWIMBcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:32:39 -0400
Subject: Re: [PATCH 1/1] VFS: fixes a bug in sys_linkat()
From: Ram Pai <linuxram@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nacc@us.ibm.com
In-Reply-To: <20060913011100.GC29920@ftp.linux.org.uk>
References: <200609130057.k8D0vcqJ028474@ram.us.ibm.com>
	 <20060913011100.GC29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 18:32:22 -0700
Message-Id: <1158111142.6967.105.camel@ram.us.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 02:11 +0100, Al Viro wrote:
> On Tue, Sep 12, 2006 at 05:57:38PM -0700, Ram Pai wrote:
> > Hardlink using sys_linkat() returns EXDEV when the source and the destination
> > point to the same filesystem, residing under different mounts.
> 
> ... and that is absolutely deliberate.  Ability to restrict links to
> a subtree is a deliberate feature.

But wondering what side effects will it have if we allowed it to create
hardlinks?  

RP



