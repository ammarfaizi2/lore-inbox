Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSLJWch>; Tue, 10 Dec 2002 17:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbSLJWcg>; Tue, 10 Dec 2002 17:32:36 -0500
Received: from dp.samba.org ([66.70.73.150]:48296 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266199AbSLJWcg>;
	Tue, 10 Dec 2002 17:32:36 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15862.27978.670448.901111@argo.ozlabs.ibm.com>
Date: Wed, 11 Dec 2002 09:40:10 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: xxx_check_var
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I look at atyfb_check_var or aty128fb_check_var, I see that they
will alter the contents of *info->par.  Isn't this a bad thing?  My
understanding was that after calling check_var, you don't necessarily
call set_par next (particularly if check_var returned an error).
Also I notice that atyfb_set_par and aty128fb_set_par don't look at
info->var, they simply set the hardware state based on the contents of
*info->par.

Looking at skeletonfb.c, it seems that this is the wrong behaviour.  I
had fixed the aty128fb.c driver in the linuxppc-2.5 tree.  James, if
you let me know whether the current behaviour is wrong or not, I'll
fix them and send you the patch.

Paul.
