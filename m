Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTD3X46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTD3X45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:56:57 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33039
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262590AbTD3X44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:56:56 -0400
Subject: Re: must-fix list for 2.6.0
From: Robert Love <rml@tech9.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@digeo.com>, Rick Lindsley <ricklind@us.ibm.com>,
       solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org,
       frankeh@us.ibm.com
In-Reply-To: <20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk>
References: <20030430121105.454daee1.akpm@digeo.com>
	 <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
	 <20030430162108.09dbd019.akpm@digeo.com>
	 <20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1051747753.17629.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 30 Apr 2003 20:09:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-30 at 19:47, viro@parcelfarce.linux.theplanet.co.uk
wrote:

> Excuse me, but WTF do they spin on the sched_yield() in the first place?
> _That_ sounds like utterly broken...

I agree it is broken, but it was considered a method of implementing
user-space locking for a long time..

The problem is in LinuxThreads mostly, I guess, according to Andrew.

But the big offender we hear about ten times a day is Open Office, which
calls sched_yield() after a lot of GUI operations, seemingly in the name
of interactivity.  It is busted and Red Hat shipped a yield-less Open
Office in RH9 which works fine.

	Robert Love

