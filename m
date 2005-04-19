Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVDSSet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVDSSet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 14:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDSSet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 14:34:49 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:22672
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261554AbVDSSen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 14:34:43 -0400
Date: Tue, 19 Apr 2005 11:28:35 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more packets than interrupts
Message-Id: <20050419112835.5efd4132.davem@davemloft.net>
In-Reply-To: <875fe4a505041908466117acf4@mail.gmail.com>
References: <875fe4a505041908466117acf4@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005 15:46:07 +0000
Francesco Oppedisano <francesco.oppedisano@gmail.com> wrote:
> Can every driver manage many packets per call?

Most can.  If more packets arrive between between when the chip
signals the interrupt and the cpu actually gets to the driver
interrupt handler, multiple packets per interrupt can easily happen.
