Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTH1NvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTH1NvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:51:14 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:62350 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S264023AbTH1NvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:51:11 -0400
Date: Thu, 28 Aug 2003 22:53:20 +0900
From: Tejun Huh <tejun@aratech.co.kr>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Tejun Huh <tejun@aratech.co.kr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache statistics race in 2.4
Message-ID: <20030828135320.GA23559@atj.dyndns.org>
References: <20030828022748.GA20792@atj.dyndns.org> <20030828154350.4239fb19.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828154350.4239fb19.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 03:43:50PM +0200, Stephan von Krawczynski wrote:
> On Thu, 28 Aug 2003 11:27:49 +0900
> Tejun Huh <tejun@aratech.co.kr> wrote:
> 
> >  Hello,
> > 
> >  In fs/dcache.c, dentry_stat.nr_dentry is not protected by anything
> > and on a busy SMP machine, after a while, the count goes wild.
> 
> Can you shortly describe what user experiences in this case?
> 

 Hello Stephan,

 Not much, just weird numbers in /proc/sys/fs/dentry-state.  isag may
show continuously increasing graph.  Only statistic is affected.

-- 
tejun

