Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTDQIx1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 04:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbTDQIx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 04:53:27 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48151 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261288AbTDQIx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 04:53:26 -0400
Date: Thu, 17 Apr 2003 09:04:44 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Message-ID: <20030417090444.A4209@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0304161904170.1534-100000@home.transmeta.com> <1050569207.1412.1.camel@laptop.fenrus.com> <Pine.LNX.4.44.0304171102040.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304171102040.12110-100000@serv>; from zippel@linux-m68k.org on Thu, Apr 17, 2003 at 11:02:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 11:02:43AM +0200, Roman Zippel wrote:
> Hi,
> 
> On 17 Apr 2003, Arjan van de Ven wrote:
> 
> > it can do that ANYWAY for all kinds of things.
> > We really should ask the gcc folks to add a
> > -fdontyoudareusefloatingpoint flag (well different name probably) to
> > make sure it never ever will generate FP code. (would also help catch
> > abusers of FP code in the kernel as a bonus ;)
> 
> -msoft-float?

that is a decent start but has a different effect, eg it doesnt' actually
forbid gcc from generatic fpu code, just tells it to use emu lib functions
for it .
