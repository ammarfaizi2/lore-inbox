Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267931AbTBEMLk>; Wed, 5 Feb 2003 07:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267932AbTBEMLk>; Wed, 5 Feb 2003 07:11:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39759 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267931AbTBEMLg>; Wed, 5 Feb 2003 07:11:36 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302051221.h15CL7i02421@devserv.devel.redhat.com>
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Wed, 5 Feb 2003 07:21:07 -0500 (EST)
Cc: benh@kernel.crashing.org (Benjamin Herrenschmidt), alan@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030205123951.54207275.skraw@ithnet.com> from "Stephan von Krawczynski" at Feb 05, 2003 12:39:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > a problem a user reported me as well. It's interesting because it's
> > apparently running UP, so it's not the SMP race found by Ross. It's
> > definitely a problem with shared interrupt though.

The race Ross found can bite you on a uniprocessor box as well I think.
It just needs the irq to hit in the right spot. The more interesting 
question is how the current -ac behaves under the same treatment
