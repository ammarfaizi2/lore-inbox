Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTEDUpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTEDUpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:45:18 -0400
Received: from daimi.au.dk ([130.225.16.1]:3458 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id S261686AbTEDUpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:45:17 -0400
Message-ID: <3EB57EC5.7BC7E0F@daimi.au.dk>
Date: Sun, 04 May 2003 22:57:41 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> the first 1MB of the ASCII-armor is left unused to provide NULL pointer
> dereference protection and leave space for 16-bit emulation mappings used
> by XFree86 and others.

But in some cases you need 1MB+64KB. I think you should change the
start address from 0x00101000 to 0x00111000 so it does not overlap
the address space addressable from virtual 86 mode.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
