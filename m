Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbUKWCs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbUKWCs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUKWCqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:46:25 -0500
Received: from [211.58.254.17] ([211.58.254.17]:25996 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262500AbUKWCpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:45:43 -0500
Date: Tue, 23 Nov 2004 11:45:37 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc2 0/4] module sysfs: module sysfs related clean ups
Message-ID: <20041123024537.GA7326@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

 These are four patches to simplify/clean up implementation of module
sysfs stuff.

01_mkobj_inline.patch
	Make module.mkobj inline.  As this is simpler and what's
	usually done with kobjs when it's representing an entity.

02_module_attribute_extension.patch
	Modify module_attribute show/store methods to accept self
	argument to enable further extensions.

03_module_sections_attr_grp.patch
	Reimplement section attributes using attribute group.  This
	makes more sense, for, while they reside in a separate
	subdirectory, they belong to the ownig module and their
	lifetime exactly equals the lifetime of the owning module,
	and it's simpler.

04_module_paramters_attr_grp.patch 
	Reimplement parameter attributes using attribute group.
	Ditto.

 Thanks.

-- 
tejun

