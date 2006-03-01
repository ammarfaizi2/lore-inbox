Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWCAGQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWCAGQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 01:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWCAGQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 01:16:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63462 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932462AbWCAGQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 01:16:38 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<m18xrupuc0.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 23:15:20 -0700
In-Reply-To: <m18xrupuc0.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Tue, 28 Feb 2006 23:11:59 -0700")
Message-ID: <m14q2ipu6f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Ok.  I think I have found the big bug in my task_ref patches.
>
Nope.  It was __unhash_process just moved, it is still under
the tasklist_lock.

Eric
