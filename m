Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUIHDVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUIHDVe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269021AbUIHDVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:21:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37057 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269020AbUIHDVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:21:31 -0400
Subject: Re: [CHECKER] potential NFS deadlock in 2.6.8.1
From: Greg Banks <gnb@melbourne.sgi.com>
To: Dawson Engler <engler@coverity.dreamhost.com>
Cc: linux-kernel@vger.kernel.org, developers@coverity.com
In-Reply-To: <Pine.LNX.4.58.0409071949070.28006@coverity.dreamhost.com>
References: <Pine.LNX.4.58.0409071949070.28006@coverity.dreamhost.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094614173.20243.159.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 08 Sep 2004 13:29:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 12:49, Dawson Engler wrote:
> Hi All,
> 
> below is a possible deadlock in the linux-2.6.8.1 NFS found by a static
> deadlock checker I'm writing.  Let me know if it looks valid and/or
> whether the output is too cryptic.

Your static analysis and presentation is fine (nice work).  However
the deadlock can't occur in practice because the nfs4_state_shutdown()
function is only called from nfsd() by the last nfsd thread to die
when NFS is being shut down, so there is no thread B to deadlock with.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


