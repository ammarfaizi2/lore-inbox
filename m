Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270801AbTHKAJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 20:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbTHKAJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 20:09:34 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:35554 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270801AbTHKAJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 20:09:33 -0400
Subject: Re: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com, mikpe@csd.uu.se, m.c.p@wolk-project.de
Content-Type: text/plain
Organization: 
Message-Id: <1060559943.948.121.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Aug 2003 19:59:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:

> 2.4.21-rc1 with NCAPINTS==6 hangs at boot in the local
> APIC timer calibration step; before that it detected a
> 0MHz bus clock and the local APIC NMI watchdog was stuck.
> Correcting head.S:X86_VENDOR_ID fixes these problems.
> 
> Without correcting head.S:X86_VENDOR_ID, head.S will store
> the vendor id partly in the capabilities array. This breaks
> both the capabilities and the vendor id. I can't say why 2.6
> works, but obviously the CPU setup code has changed since 2.4.

I may be stating the obvious, but in case not...

If Jeff Garzik missed this, others will too. I hope
that a big comment gets added in both places, assuming
that automatic offset generation isn't practical.


