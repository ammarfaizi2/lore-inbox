Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSGVCtT>; Sun, 21 Jul 2002 22:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSGVCtT>; Sun, 21 Jul 2002 22:49:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53767 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315202AbSGVCtS>;
	Sun, 21 Jul 2002 22:49:18 -0400
Message-ID: <3D3B7532.96B78172@zip.com.au>
Date: Sun, 21 Jul 2002 20:00:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu patch 1/3
References: <20020718042221.8E1DA421D@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> Name: Export __per_cpu_offset so modules can use per-cpu data.

ie: so modules can access per-cpu data which is defined in
vmlinux.  afaik, modules cannot define percpu.h-style per-cpu
storage of their own, yes?

That's rather a trap.  It would be nice to ensure that any
attempt to define per-cpu data in a module fails reliably
at compile-time, please.

-
