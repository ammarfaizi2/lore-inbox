Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUDDF6w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 00:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUDDF6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 00:58:52 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:39535 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262220AbUDDF6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 00:58:50 -0500
Date: Sat, 3 Apr 2004 21:56:25 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com, wli@holomorphy.com
Subject: Re: [Patch 24/23] mask v2 - Small system optimizations
Message-Id: <20040403215625.4207750b.pj@sgi.com>
In-Reply-To: <20040402001545.2dbb7894.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
	<20040402001545.2dbb7894.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forget [Patch 24/23].  This patch is bad.

The C preprocessor does not bind symbols the way this patch requires. 
With this patch, including both cpumask.h and nodemask.h in the same
header would end up with a broken mixture of implementations if cpumasks
were bigger than one word, but nodemasks not.

[Patch 24a/23] will be out shortly, replacing this patch. 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
