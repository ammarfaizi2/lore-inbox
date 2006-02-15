Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWBOKns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWBOKns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBOKns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:43:48 -0500
Received: from [218.25.172.144] ([218.25.172.144]:27143 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751144AbWBOKnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:43:47 -0500
Date: Wed, 15 Feb 2006 18:43:45 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
Message-ID: <20060215104345.GA2879@localhost.localdomain>
References: <20060215085456.GA2481@localhost.localdomain> <20060215010559.55b55414.akpm@osdl.org> <20060215093136.GA2600@localhost.localdomain> <43F30346.1070802@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F30346.1070802@argo.co.il>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 12:32:38PM +0200, Avi Kivity wrote:
> Coywolf Qi Hunt wrote:
> 
> >On Wed, Feb 15, 2006 at 01:05:59AM -0800, Andrew Morton wrote:
> > 
> >
> >>Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> >>   
> >>
> >>>I see system admins often confused when they sysctl 
> >>>vm.overcommit_memory.
> >>>This patch makes overcommit_memory enumeration sensible.
> >>>
> >>>0 - no overcommit
> >>>1 - always overcommit
> >>>2 - heuristic overcommit (default)
> >>>
> >>>I don't feel this would break any userspace scripts.
> >>>     
> >>>
> >>eh?   If any such scripts exist, they'll break.
> >>
> >>Confused.
> >>   
> >>
> >
> >That's a corner case. Let'em break and fix.  Otherwise, users will
> >be confused. Even they get it right, after some weeks they'll have
> >to re-read the doc. A logical user interface is important to human.
> > 
> >
> 
> If I have
> 
>  vm.overcommit_memory = 2
> 
> in my /etc/sysctl.conf, its meaning silently changes. I'll know about 
> it during the next oomkiller pass.

Indeed. See, the breakage doesn't hurt.
-- 
Coywolf Qi Hunt
