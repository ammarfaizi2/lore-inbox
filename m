Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbUDRALh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbUDRALf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:11:35 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:7296
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S264083AbUDRALf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:11:35 -0400
Subject: Re: vmscan.c heuristic adjustment for smaller systems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Singer <elf@buici.com>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040417165151.24b1fed5.akpm@osdl.org>
References: <20040417193855.GP743@holomorphy.com>
	 <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org>
	 <20040417233037.GA15576@flea>  <20040417165151.24b1fed5.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082247084.3619.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 17:11:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 16:51, Andrew Morton wrote:

> What happens if you do the big file copy, then run `sync', then do the ls?

You shouldn't ever need to do "sync" with NFS unless you are using
mmap(). close() will suffice to flush out all dirty pages in the case of
ordinary file writes.

Cheers,
  Trond
