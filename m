Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTF0Fub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 01:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTF0Fua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 01:50:30 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:31182 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263310AbTF0Fua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 01:50:30 -0400
To: Andrey Panin <pazke@donpac.ru>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] irq handling code consolidation (common part)
References: <20030626110247.GT9679@pazke> <20030626175554.GA22089@krispykreme>
	<20030627050020.GX9679@pazke>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 Jun 2003 15:04:13 +0900
In-Reply-To: <20030627050020.GX9679@pazke>
Message-ID: <buowuf86opu.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin <pazke@donpac.ru> writes:
> BTW sparc implementation of irq_itoa() uses static buffer for the formatted 
> string, is it really irq/preempt safe ?

Passinf in a result buffer seems simplest (maybe have the arch define a
macro for the max-length).

[btw the name `irq_itoa' seems a bit odd; how about `irq_name' (or
`irq_rep' for clu-lovers)?]

-miLes
-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
