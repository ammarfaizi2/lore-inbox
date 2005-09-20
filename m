Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVITMVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVITMVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVITMVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:21:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27350 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964989AbVITMVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:21:35 -0400
Date: Tue, 20 Sep 2005 07:21:20 -0500
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, zippel@linux-m68k.org, akpm@osdl.org,
       torvalds@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-ID: <20050920122120.GE21435@lnx-holt.americas.sgi.com>
References: <Pine.LNX.4.61.0509121821270.3743@scrub.home> <20050912153135.3812d8e2.pj@sgi.com> <Pine.LNX.4.61.0509131120020.3728@scrub.home> <20050913103724.19ac5efa.pj@sgi.com> <Pine.LNX.4.61.0509141446590.3728@scrub.home> <20050914124642.1b19dd73.pj@sgi.com> <Pine.LNX.4.61.0509150116150.3728@scrub.home> <20050915104535.6058bbda.pj@sgi.com> <20050920005743.4ea5f224.pj@sgi.com> <20050920120523.GC21435@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920120523.GC21435@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, too early in the morning...  Aside from other typoes

> If we can agree on that, then the exit path becomes
> 	if (atomic_dec_and_lock(&current->cpuset.refcount)) {

	if (atomic_dec_and_lock(&cs->refcount, &cs->parent->child_list)

Sorry,
Robin
