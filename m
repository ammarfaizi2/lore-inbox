Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVBKH75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVBKH75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVBKH75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:59:57 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:57267 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262214AbVBKH74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:59:56 -0500
Date: Thu, 10 Feb 2005 23:59:53 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.Stanford.EDU
Subject: [CHECKER] Does sys_sync (ext2, 2.6.x) flush metadata?
Message-ID: <Pine.GSO.4.44.0502102345540.8091-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We're working on a file system checker and have a question regarding what
sys_sync actually does.  It appears to us that sys_sync should sync both
data and metadata, and wait until both data and metadata hit the disk
before it returns.  Is this true for all the file systems (especially
ext2) for kernel 2.6.x?  I've gotten many "error" traces for ext2, where
directory entries are not flushed to disk after sys_sync.  In other words,
even if users do call sys_sync, a crash after sys_sync call can still
cause file losses.  Is this intended?

Thanks,
-Junfeng

