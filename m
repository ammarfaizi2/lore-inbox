Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTAOIho>; Wed, 15 Jan 2003 03:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbTAOIho>; Wed, 15 Jan 2003 03:37:44 -0500
Received: from h-64-105-35-14.SNVACAID.covad.net ([64.105.35.14]:14996 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265872AbTAOIhn>; Wed, 15 Jan 2003 03:37:43 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 15 Jan 2003 00:46:26 -0800
Message-Id: <200301150846.AAA01104@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: [PATCH] Proposed module init race fix.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-01-15, Rusty Russell wrote:
>It's possible to start using a module, and then have it fail
>initialization.  In 2.4, this resulted in random behaviour.  One
>solution to this is to make all interfaces two-stage: reserve
>everything you need (which might fail), the activate them.  This
>means changing about 1600 modules, and deprecating every interface
>they use.

	Could you explain this "random behavior" of 2.4 a bit more?
As far as I know, if a module's init function fails, it must
unregister everything that it has registered up to that point.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

