Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWHPOZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWHPOZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWHPOZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:25:04 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:44672 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751116AbWHPOZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:25:02 -0400
Date: Wed, 16 Aug 2006 22:48:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 7/7] file: Modify struct fown_struct to use a struct pid.
Message-ID: <20060816184851.GC472@oleg>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> <11556661943487-git-send-email-ebiederm@xmission.com> <20060816184529.GB472@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816184529.GB472@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Oleg Nesterov wrote:
>
> On 08/15, Eric W. Biederman wrote:
> >
> > File handles can be requested to send sigio and sigurg
> > to processes.   By tracking the destination processes
> > using struct pid instead of pid_t we make the interface
> > safe from all potential pid wrap around problems.
>
> ....
> 
> The second change is good (I'd say this is bugfix). It is
> not possible anymore to send the signal to not yet created
> processes via fcntl(F_SETOWN, last_pid + a_little), or hit
> a problem with pid re-use.

Damn, I read the patch but forgot to read the changelog :)
It clearly says "safe from all potential pid wrap around problems",
sorry.

Oleg.

