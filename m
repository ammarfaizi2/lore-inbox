Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265400AbUEUGWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbUEUGWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 02:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUEUGWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 02:22:40 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:46317
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265400AbUEUGWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 02:22:38 -0400
Message-ID: <40AD9C5E.1020603@redhat.com>
Date: Thu, 20 May 2004 23:06:22 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040519
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520155217.7afad53b.akpm@osdl.org>
In-Reply-To: <20040520155217.7afad53b.akpm@osdl.org>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Is it safe to go adding a new argument to an existing syscall in this manner?

Yes.  This is a multiplexed syscall and the opcode decides which syscall
parameter is used.


> It'll work OK on x86 because of the stack layout but is the same true of
> all other supported architectures?

We add parameters at the end.  This does not influence how previous
values are passed.  And especially for syscalls it makes no difference.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
