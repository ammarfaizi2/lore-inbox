Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265573AbUEZMyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUEZMyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUEZMyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:54:05 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:51381 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265584AbUEZMww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:52:52 -0400
Date: Wed, 26 May 2004 14:52:47 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI trigger switch support for debugging
In-Reply-To: <20040525193721.7c71f61d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.55.0405261447590.1025@jurand.ds.pg.gda.pl>
References: <40B1BEAC.30500@jp.fujitsu.com> <20040524023453.7cf5ebc2.akpm@osdl.org>
 <40B3F484.4030405@jp.fujitsu.com> <20040525184148.613b3d6e.akpm@osdl.org>
 <40B400D1.1080602@jp.fujitsu.com> <20040525193721.7c71f61d.akpm@osdl.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004, Andrew Morton wrote:

> If the machine locks up with interrupts enabled we can use sysrq-T and
> sysrq-P.  If it locks up with interrupts disabled the NMI watchdog will
> automatically produce the same info as your patch.  So what advantage does
> the patch add?

 A system may have no NMI watchdog available (which requires an APIC), yet
still have an NMI button.  Though this is probably the case only for IA32
systems that are several years old now.

 Note that EISA systems have a different NMI watchdog, based on a second
8254 PIT, which we've never attempted to make use of.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
