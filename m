Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbSKNKaz>; Thu, 14 Nov 2002 05:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKNKaz>; Thu, 14 Nov 2002 05:30:55 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:33177 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S264825AbSKNKaz>; Thu, 14 Nov 2002 05:30:55 -0500
Message-Id: <200211141035.gAEAZt2t017446@pool-151-204-203-202.delv.east.verizon.net>
Date: Thu, 14 Nov 2002 05:35:53 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: module-init-tools breaks kallsyms
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [151.204.203.202] at Thu, 14 Nov 2002 04:37:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Install of module-init-tools moves the old tools to *.old but it doesn't
address kallsyms.  In the case of kallsyms being a link to insmod, it
breaks.  Since the new insmod is supposed to call insmod.old when
appropriate, I'm not sure why it breaks.  But it doesn't work here.

To successfully compile a kernel < 2.5.47-bk2 after module-init-tools
installation, with kallsyms being a symlink, you need to link it to
insmod.old instead.

-- 
Skip
