Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268794AbUIHALb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbUIHALb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUIHALb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:11:31 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:26563
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268794AbUIHAK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:10:57 -0400
Date: Tue, 7 Sep 2004 17:08:07 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, hpa@zytor.com,
       bgerst@didntduck.org, Riley@Williams.Name
Subject: Re: PROBLEM: x86 alignment check bug
Message-Id: <20040907170807.2e8bba1d.davem@davemloft.net>
In-Reply-To: <413E498D.4020807@vmware.com>
References: <413E498D.4020807@vmware.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2004 16:51:41 -0700
Zachary Amsden <zach@vmware.com> wrote:

> Clearly, this is not correct.  Considering how difficult the fix is (the 
> kernel must disassemble the faulting instruction and use register 
> information to determine the faulting address),

While it is more difficult to disassemble x86 opcodes,
what you describe is exactly how we handle this on
sparc64.  In fact we do opcode decoding for most fault
types.
