Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVCHUkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVCHUkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCHUf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:35:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:60306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262113AbVCHUaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:30:46 -0500
Date: Tue, 8 Mar 2005 12:29:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: rlrevell@joe-job.com, hch@infradead.org, mingo@elte.hu, mpm@selenic.com,
       joq@io.com, cfriesen@nortelnetworks.com, chrisw@osdl.org,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050308122934.3ef35f9e.akpm@osdl.org>
In-Reply-To: <200503081911.j28JBL4D014012@localhost.localdomain>
References: <1110308156.4401.4.camel@mindpipe>
	<200503081911.j28JBL4D014012@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis <paul@linuxaudiosystems.com> wrote:
>
> >And as I mentioned a few times, the authors have neither the inclination
> >nor the ability to do that, because they are not kernel hackers.  The
> >realtime LSM was written by users (not developers) of the kernel, to
> >solve a specific real world problem.  No one ever claimed it was the
> >correct solution from the kernel POV.
> 
> i would just like to add that its very disappointing that the LSM,
> having been included in the kernel (apparently very much against
> Christoph's and others' advice) turns out to be so useless. from
> outside lkml, LSM appeared to be a mechanism to allow
> non-kernel-developers to create new security policies (perhaps even
> mechanisms) without trying to tackle the entire kernel. instead, we
> are now getting a fix which, while it solves the same problem, has
> required substantive analysis of its effect on the overall kernel, and
> will require continued vigilance to ensure that it doesn't now or
> later cause unintended side effects. LSM appeared to be the "right"
> way to do this in terms of modularity - it is disappointing to find it
> has so little support (close to zero to judge from this debate) on
> LKML despite being present in the kernel.
> 

That, plus the fact that inherited capabilities could also be used here,
except they don't work right.  That's a nice, simple and long-standing
kernel feature which I think we should have fixed up before piling in more
security features.

But I've said that often enough.  If nobody has a sufficient need for
fixed-up-caps to actually put work into it, nothing happens.  And it's a
lot of work, because this is a scary feature.

