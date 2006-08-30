Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWH3GMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWH3GMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWH3GMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:12:42 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:59044 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751089AbWH3GMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:12:41 -0400
Date: Wed, 30 Aug 2006 08:11:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Peter Grandi <pg_lkm@lkm.for.sabi.co.UK>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
In-Reply-To: <44F4AE80.4010607@goop.org>
Message-ID: <Pine.LNX.4.61.0608300759200.9263@yvahk01.tjqt.qr>
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
 <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
 <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
 <44F46E8C.1000308@goop.org> <17652.35152.661745.96581@base.ty.sabi.co.UK>
 <44F4AE80.4010607@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The load address for ET_EXEC executables is defined as 0x08048000;
> you can use ET_DYN if you want to load them elsewhere.  Using lower
> addresses allows the use of instructions with smaller pointers and
> offsets (though this might be less important on x86).

Less on x86. HTE tells me there are only two ways (EB and E9):

      EB ??                 jmp OFFSET8     for 16/32/64
      E9 ?? ??              jmp OFFSET16    for 16-bit mode
      E9 ?? ?? ?? ??        jmp OFFSET32    for 32/64-bit mode



Jan Engelhardt
-- 
