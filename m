Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWCWWb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWCWWb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWCWWb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:31:57 -0500
Received: from defout.telus.net ([204.209.205.55]:32680 "EHLO
	priv-edmwes26.telusplanet.net") by vger.kernel.org with ESMTP
	id S964938AbWCWWb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:31:56 -0500
Date: Thu, 23 Mar 2006 17:31:38 -0500
From: Stephen Hassard <steve@hassard.net>
To: Edouard Gomez <ed.gomez@free.fr>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] 2.6.16-ck1
Message-ID: <20060323223138.GA9305@hassard.net>
References: <200603202145.31464.kernel@kolivas.org> <20060323113118.GA9329@spherenet.spherevision.org> <dvv0ob$nql$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dvv0ob$nql$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:34:19PM +0100, Edouard Gomez wrote:
> Rodney Gordon II wrote:
> >The new Yukon2 "sky2" driver: This one really pissed me off. It had me
> >thinking apache2 AND my linksys router we're on the brink. For some
> I never had the chance to make the sk98lin one working on my box, so I 
> backported sky2 to 2.6.15 quite a few times from netdev-2.6 git tree. 

It might be worth replacing the sky2 driver with the newest bleeding 
edge one over here:

http://developer.osdl.org/shemminger/prototypes/sky2-1.0msi.tar.gz

You might also want to check the developer's blog entry:
http://developer.osdl.org/shemminger/blog/?p=25

---
sky2 1.0?

Looks like a found the root cause of the sky2 hangs on pci-express. I 
copied some code from the SysKonnect driver that reconfigured the 
pci-express max request size. This probably caused receive dma engine to 
fail in face of contention. That will teach me to stop copy/pasting in 
bugs.
---

It might fix some of you issues ..

later,
Steve Hassard
