Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbTDGSfp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTDGSfp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:35:45 -0400
Received: from home.wiggy.net ([213.84.101.140]:61389 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262977AbTDGSfo (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:35:44 -0400
Date: Mon, 7 Apr 2003 20:47:19 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407184719.GK4411@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030407102005.4c13ed7f.manushkinvv@desnol.ru> <200304070709.h37792815083@mozart.cs.berkeley.edu> <20030407113534.1de8dc91.agri@desnol.ru> <b6s3k4$i0i$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6s3k4$i0i$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously H. Peter Anvin wrote:
> b) This is a security hole, in which case /proc needs to be fixed.  In
> particular, the open("/proc/self/fd/3", O_RDWR) in my example above
> should return EPERM.

proc might not be a problem if you deal with a chroot or namespace which
doesn't have proc mounted and no processes running with mount
capabilities. flink could still be a problem in those situations.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
