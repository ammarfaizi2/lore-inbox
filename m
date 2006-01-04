Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWADXPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWADXPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWADXPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:15:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751822AbWADXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:15:41 -0500
Date: Wed, 4 Jan 2006 15:17:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: jlan@engr.sgi.com, nagar@watson.ibm.com, linux-kernel@vger.kernel.org,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, pj@sgi.com, erikj@sgi.com,
       steiner@sgi.com, jh@sgi.com
Subject: Re: [ckrm-tech] Re: [Patch 6/6] Delay accounting: Connector
 interface
Message-Id: <20060104151730.77df5bf6.akpm@osdl.org>
In-Reply-To: <1136414431.22868.115.camel@stark>
References: <43BB05D8.6070101@watson.ibm.com>
	<43BB09D4.2060209@watson.ibm.com>
	<43BC1C43.9020101@engr.sgi.com>
	<1136414431.22868.115.camel@stark>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley <matthltc@us.ibm.com> wrote:
>
> > We need to move both proc_exit_connector(tsk) and
> > cnstats_exit_connector(tsk) up to before exit_mm(tsk) statement.
> > There are task statistics collected in task->mm and those stats
> > will be lost after exit_mm(tsk).
> > 
> > Thanks,
> >  - jay
> > 
> > > 	exit_notify(tsk);
> > > #ifdef CONFIG_NUMA
> > > 	mpol_free(tsk->mempolicy);
> > >-
> 
> 	Good point. The assignment of the task exit code will also have to move
> up before exit_mm(tsk) because the process event connector exit function
> retrieves the exit code from the task struct.

Could someone please volunteer to do the patch?
