Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVBWN5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVBWN5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 08:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVBWN5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 08:57:08 -0500
Received: from [83.102.214.158] ([83.102.214.158]:50618 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261295AbVBWN5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 08:57:05 -0500
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
	<m3r7j8wwy2.fsf@bzzz.home.net>
	<1109079718.421b36a621d16@webmail.tu-harburg.de>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Wed, 23 Feb 2005 16:55:14 +0300
In-Reply-To: <1109079718.421b36a621d16@webmail.tu-harburg.de> (Jan Blunck's
 message of "Tue, 22 Feb 2005 14:41:58 +0100")
Message-ID: <m3mztv8jp9.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jan Blunck (JB) writes:

 JB> Nope, d_alloc() is setting d_flags to DCACHE_UNHASHED. Therefore it is not found
 JB> by __d_lookup() until it is rehashed which is implicit done by ->lookup().

that means we can have two processes allocated dentry for
same name. they'll call ->lookup() each against own dentry,
fill them and hash. so, we'll get two equal dentries. 
is that OK?

thanks, Alex

