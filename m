Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbTEMXX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTEMXX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:23:27 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:30353 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S263804AbTEMXXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:23:25 -0400
Date: Tue, 13 May 2003 16:34:52 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4 fails to boot
Message-ID: <20030513233452.GO32128@ca-server1.us.oracle.com>
Mail-Followup-To: akpm@digeo.com, linux-kernel@vger.kernel.org
References: <20030513221435.GI32128@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513221435.GI32128@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 03:14:36PM -0700, Joel Becker wrote:
> Andrew,
> 	2.5.69-mm4 is failing to boot.  It completes init_rootfs() in
> mnt_init() but does not complete init_mount_tree().  Call me dumb, but

	Ok, looks like it is waiting at read_lock(&tasklist_lock) in
init_mount_tree().  I wonder what has the lock.  Off to check.

Joel

-- 

"When I am working on a problem I never think about beauty. I
 only think about how to solve the problem. But when I have finished, if
 the solution is not beautiful, I know it is wrong."
         - Buckminster Fuller

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
