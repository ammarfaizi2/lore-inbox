Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSHGLHM>; Wed, 7 Aug 2002 07:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSHGLHM>; Wed, 7 Aug 2002 07:07:12 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19091 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317611AbSHGLHM>; Wed, 7 Aug 2002 07:07:12 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208071110.g77BAaH05474@devserv.devel.redhat.com>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
To: ak@suse.de (Andi Kleen)
Date: Wed, 7 Aug 2002 07:10:36 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
       alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020807130417.A19231@wotan.suse.de> from "Andi Kleen" at Aug 07, 2002 01:04:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dep_bool .... $CONFIG_X86_32
> 
> Would that be acceptable for you?  (ok that would not cover ppc32 for 
> example, but they may have other issues with the driver) 

dep_bool doesnt have negations, bracketing or or operations. Thats why
CML1 can't handle it but CML2 probably could have

> They will discover it when they don't find a driver for an device and
> can then find the disabled configuration and look into fixing it
> (for someone able to fix the driver checking the configuration should
> be trivial) 

No they'll mail you asking where it has gone

> In my opinion it is just not acceptable when the enable the driver by
> mistake or load the wrong module and it crashes.

Thats a packaging issue for distributed prebuilt kernel trees. Also crashes
are the only way you are going to find out what needs fixing, who wants to
fix it and the like
