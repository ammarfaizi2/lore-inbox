Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262554AbSJBTSp>; Wed, 2 Oct 2002 15:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262557AbSJBTSp>; Wed, 2 Oct 2002 15:18:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:60428
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262554AbSJBTSn>; Wed, 2 Oct 2002 15:18:43 -0400
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
From: Robert Love <rml@tech9.net>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, willy@debian.org
In-Reply-To: <20021002185814.GA23100@compsoc.man.ac.uk>
References: <20021002023901.GA91171@compsoc.man.ac.uk>
	 <20021002032327.GA91947@compsoc.man.ac.uk>
	 <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk>
	 <3D9B2734.D983E835@digeo.com>
	 <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk>
	 <20021002185814.GA23100@compsoc.man.ac.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1033585829.24108.66.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 15:10:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 14:58, John Levon wrote:

> How will cond_resched() work ?  Surely that will only give a chance if
> the current process has reached the end of its timeslice (need_resched)
> ? Isn't "schedule()" the right thing here ?

need_resched is set whenever there is a higher priority process that is
now runnable (it is set on wake_up()).  Otherwise cond_resched() would
be fairly worthless.. and kernel preemption, etc.

	Robert Love

