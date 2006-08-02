Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWHBWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWHBWSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWHBWSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:18:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19106 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932278AbWHBWSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:18:12 -0400
In-Reply-To: <20060802.143204.16511279.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: catalin.marinas@gmail.com, cxzhang@watson.ibm.com, czhang.us@gmail.com,
       jmorris@namei.org, linux-kernel@vger.kernel.org,
       michal.k.k.piotrowski@gmail.com, netdev@vger.kernel.org,
       sds@tycho.nsa.org
Subject: Re: [Patch] kernel memory leak fix for af_unix datagram getpeersec patch
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF4882A75D.C66DD3D0-ON852571BE.007A0271-852571BE.007A82C3@us.ibm.com>
From: Xiaolan Zhang <cxzhang@us.ibm.com>
Date: Wed, 2 Aug 2006 18:18:07 -0400
X-MIMETrack: Serialize by Router on D01ML605/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 08/02/2006 18:18:10,
	Serialize complete at 08/02/2006 18:18:10
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

I did test it with CONFIG_SECURITY disabled, but did not catch the warning 
-- I verified that the build completes with a valid vmlinux image.  There 
are many warnings (device drivers, and others) during the build and I 
didn't do a grep to find which one is specific to my patch.  Next time 
I'll do a diff on warnings too.

thanks,
Catherine

David Miller <davem@davemloft.net> wrote on 08/02/2006 05:32:04 PM:

> 
> Can you also remember to test your patches with CONFIG_SECURITY
> disabled, as you also promised in the past several times?!??!?!
> 
> In file included from init/main.c:34:
> include/linux/security.h: In function rxsecurity_release_secctxry:
> include/linux/security.h:2757: warning: rxreturnry with a value, in 
> function returning void
> 
> I'll fix this one up, but this is getting rediculious.

