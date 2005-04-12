Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVDLVaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVDLVaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVDLV0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:26:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55803 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263007AbVDLVZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:25:21 -0400
Subject: Re: FUSYN and RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       mingo@elte.hu
In-Reply-To: <20050412203329.GA15304@tsunami.ccur.com>
References: <1113329702.23407.148.camel@dhcp153.mvista.com>
	 <20050412203329.GA15304@tsunami.ccur.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113341119.6389.3.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Apr 2005 14:25:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 13:33, Joe Korty wrote:
> On Tue, Apr 12, 2005 at 11:15:02AM -0700, Daniel Walker wrote:
> 
> > It seems like these two locks are going to interact on a very limited
> > basis. Fusyn will be the user space mutex, and the RT mutex is only in
> > the kernel. You can't lock an RT mutex and hold it, then lock a Fusyn
> > mutex (anyone disagree?). That is assuming Fusyn stays in user space.
> 
> Well yeah, but you could lock a fusyn, then invoke a system call which
> locks a kernel semaphore.


Right .. For deadlock detection, I want to assume that the fusyn lock is
on the outer level. That way both deadlock detection system will work
properly (in theory).

Daniel 

