Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWARFjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWARFjd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWARFjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:39:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:60576 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030259AbWARFjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:39:32 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: xfs depends on exportfs 
In-reply-to: Your message of "Tue, 17 Jan 2006 21:16:51 BST."
             <Pine.LNX.4.61.0601172112550.11929@yvahk01.tjqt.qr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Jan 2006 16:39:20 +1100
Message-ID: <10055.1137562760@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt (on Tue, 17 Jan 2006 21:16:51 +0100 (MET)) wrote:
>I could not find a clue on the first try on why xfs needs exportfs.
>The Kconfig says "select EXPORTFS if CONFIG_NFSD!=n", but there are no 
>occurrences of CONFIG_NFS* or CONFIG_EXP* in any of the files in fs/xfs/.
>Did I miss something or this a superfluous line in Kconfig? Interestingly 
>tho, `modinfo xfs.ko` returns "exportfs", so I suppose it's somewhere, well 
>hidden. If so, where?

XFS uses find_exported_dentry().

Hint: nm fs/xfs/xfs.ko | grep ' U .*exp'

