Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWEUXcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWEUXcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWEUXcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:32:17 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:25767 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751558AbWEUXcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:32:16 -0400
Date: Mon, 22 May 2006 01:32:15 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com,
       clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060521233215.GA15353@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
	devel@openvz.org, sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com,
	clg@fr.ibm.com
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518103430.080e3523.akpm@osdl.org> <20060519124235.GA32304@MAIL.13thfloor.at> <20060519081334.06ce452d.akpm@osdl.org> <20060521225735.GA9048@elf.ucw.cz> <m1ejynnezp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejynnezp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 05:18:50PM -0600, Eric W. Biederman wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > Well, if pid #1 virtualization is only needed for pstree, we may want
> > to fix pstree instead :-).

yes, actually this and init itself (which uses the 
pid to switch between init and telinit behaviour)
are the only two applications we found so far ...

and as far as I know, those work with non pid=1
values on other operating systems (inside containers)

a fix there would definitely be appreciated and 
I think it would not hurt normal behaviour ...

> One thing that is not clear is if isolation by permission checks is
> any easier to implement than isolation with a namespace.

for the pid space, I'm not really sure if isolation
is really cheaper than virtualization, but for the
network space for example, a virtualization solution
which is as lightweigth as the isolation is probably
more challenging, although not impossible ...

> Isolation at permission checks may actually be more expensive in terms
> of execution time, and maintenance.

again, for the pid space, maintenance is quite low ..

best,
Herbert

> Eric
