Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVDICmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVDICmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 22:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDICmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 22:42:52 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:19641 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261192AbVDICmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 22:42:50 -0400
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: const qualifiers on function returns type
To: Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 09 Apr 2005 04:42:44 +0200
References: <3RcNK-4PC-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DK5vr-0002LO-PJ@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot <bboissin@gmail.com> wrote:

> extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
> 
> I was wondering what means const for a function returns type.
> K&R doesn't say anything about this and gcc-4 warns (warning: type
> qualifiers ignored on function return type)

It used to be a hint that the function has no side effect nor depends on
any variable besides the parameters. Calls to those functions may be cached
or omitted.
-- 
Fun things to slip into your budget
Paradigm pro-activator (a whole pack)
        (you mean beer?)
