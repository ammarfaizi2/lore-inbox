Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVKSBUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVKSBUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVKSBUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:20:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7317
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932155AbVKSBUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:20:43 -0500
Date: Fri, 18 Nov 2005 17:19:43 -0800 (PST)
Message-Id: <20051118.171943.53979015.davem@davemloft.net>
To: sam@ravnborg.org
Cc: akpm@osdl.org, davej@redhat.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051119003435.GA29775@mars.ravnborg.org>
References: <20051117.194239.37311109.davem@davemloft.net>
	<20051117200354.6acb3599.akpm@osdl.org>
	<20051119003435.GA29775@mars.ravnborg.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 Nov 2005 01:34:35 +0100

> On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
> > "David S. Miller" <davem@davemloft.net> wrote:
> > >
> > > The deprecated warnings are so easy to filter out, so I don't think
> > >  noise is a good argument.  I see them all the time too.
> > 
> > That works for you and me.  But how to train all those people who write
> > warny patches?
> 
> Would it work to use -Werror only on some parts of the kernel.
> Thinking of teaching kbuild to recursively apply a flags to gcc.
> 
> Then we could say that kernel/ should be warning free (to a start).

Many ports already add -Werror to the CFLAGS via their
arch/${ARCH}/* makefiles.
