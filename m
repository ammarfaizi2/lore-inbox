Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbVGOL3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbVGOL3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVGOL31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:29:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23473 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263293AbVGOL1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:27:52 -0400
Subject: Inotify patch missed arch/x86_64/ia32/sys_ia32.c
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, David Woodhouse <dwmw2@redhat.com>,
       Stephen Tweedie <sct@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121426860.1909.52.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 15 Jul 2005 12:27:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The inotify patch just added a line

+				fsnotify_open(f->f_dentry);

to sys_open, but it missed the x86_64 compatibility sys32_open()
equivalent in arch/x86_64/ia32/sys_ia32.c.

Andi, perhaps it's time to factor out the guts of sys_open from the flag
munging to keep as much of that code as common as possible, and avoid
this sort of maintenance problem in the future?

--Stephen

