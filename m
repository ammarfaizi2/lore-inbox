Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVBVNY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVBVNY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVBVNY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:24:59 -0500
Received: from [83.102.214.158] ([83.102.214.158]:2217 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262304AbVBVNYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:24:49 -0500
X-Comment-To: Jan Blunck
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Alex Tomas <alex@clusterfs.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] pdirops: vfs patch
References: <1109073273.421b1d7923204@webmail.tu-harburg.de>
	<m3vf8kx0ll.fsf@bzzz.home.net>
	<1109077222.421b2ce6739f8@webmail.tu-harburg.de>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Tue, 22 Feb 2005 16:23:01 +0300
In-Reply-To: <1109077222.421b2ce6739f8@webmail.tu-harburg.de> (Jan Blunck's
 message of "Tue, 22 Feb 2005 14:00:22 +0100")
Message-ID: <m3r7j8wwy2.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jan Blunck (JB) writes:

 JB> i_sem does NOT protect the dcache. Also not in real_lookup(). The lock must be
 JB> acquired for ->lookup() and because we might sleep on i_sem, we have to get it
 JB> early and check for repopulation of the dcache.

dentry is part of dcache, right? i_sem protects dentry from being
returned with incomplete data inside, right?


thanks, Alex

