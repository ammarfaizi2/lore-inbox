Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUIZWw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUIZWw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUIZWw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:52:56 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:30994 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S264704AbUIZWwy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:52:54 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.9rc2+bk hangs at: ACPI: IRQ9 SCI: Level Trigger or Checking 'hlt' instruction... OK.
Date: Mon, 27 Sep 2004 00:51:35 +0200
User-Agent: KMail/1.7
References: <200409260518.26590.arekm@pld-linux.org> <200409262023.48626.arekm@pld-linux.org>
In-Reply-To: <200409262023.48626.arekm@pld-linux.org>
Cc: kernel@kolivas.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409270051.35322.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 20:23, Arkadiusz Miskiewicz wrote:

> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > ACPI: IRQ9 SCI: Level Trigger.
Compiled vanilla version and... it works.

I was using ck patchset and tracked this problem to single patch:
http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-rc2/2.6.9-rc2-ck2/patches/9000-SuSE-117-writeback-lat.patch

This is interesting... few cond_resched() added and such problem arrived.

Anyway problem solved.
-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
