Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbTEaIHv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbTEaIHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:07:51 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:34256 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264213AbTEaIHt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:07:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Date: Sat, 31 May 2003 18:22:21 +1000
User-Agent: KMail/1.5.1
Cc: jmorris@intercode.com.au, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
References: <20030530174319.GA16687@wohnheim.fh-wedel.de> <20030530.235505.23020750.davem@redhat.com> <20030531075615.GA25089@wohnheim.fh-wedel.de>
In-Reply-To: <20030531075615.GA25089@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305311822.21823.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 17:56, Jörn Engel wrote:
> CC List pruned a little.
>
> On Fri, 30 May 2003 23:55:05 -0700, David S. Miller wrote:
> >    From: Jörn Engel <joern@wohnheim.fh-wedel.de>
> >
> >    How about preemption?  zlib operations take their time, so at least on
> >    up, it makes sense to preempt them, when not in softirq context.  Can
> >    this still be done lockless?
> >
> > You'll need to disable preemption.
>
> My gut feeling claims that this would hurt interactivity.  Con, would
> contest on a jffs2 (zlib compressed) filesystem be able to show
> interactivity problems wrt zlib?

The only way I could think of was perhaps using a load on another disk 
(io_other which is in contest) that is using jffs2 when the contest baseline 
is running on a normal filesystem - this has shown very little differences 
between filesystems normally. Otherwise if everything in contest is run on 
jffs2 it would affect every layer and hard to be sure you had a control to 
compare with.

Con
