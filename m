Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbUCJTNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUCJTNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:13:43 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:41923 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262781AbUCJTNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:13:38 -0500
Date: Wed, 10 Mar 2004 14:13:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Urban Widmark <urban@teststation.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.58.0403101122320.29087@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0403101359150.29087@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0403101244480.19728-100000@cola.local>
 <Pine.LNX.4.58.0403101122320.29087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Zwane Mwaikambo wrote:

> Thanks Urban, i have posted the following on bugzilla
> (http://bugzilla.kernel.org/show_bug.cgi?id=1671) for testing. But,
> it appears racy wrt getattr and win9x servers.

How about the following to synchronize with smb_newconn()

smb_lock_server(server);
smb_unlock_server(server);

I've already uploaded the new patch on Bugzilla, but i also came across a
smb_dir_cache related oops whilst testing, which i'm debugging.
