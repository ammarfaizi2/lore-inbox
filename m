Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbUL1T2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUL1T2G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 14:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUL1T2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 14:28:06 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:21680
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261222AbUL1T2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 14:28:04 -0500
Date: Tue, 28 Dec 2004 11:26:35 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, mingo@redhat.com
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
Message-Id: <20041228112635.5ec9a2d1.davem@davemloft.net>
In-Reply-To: <200412281421.49044.dtor_core@ameritech.net>
References: <1104249508.22366.101.camel@localhost.localdomain>
	<200412281350.44195.dtor_core@ameritech.net>
	<20041228105330.6da0f0ea.davem@davemloft.net>
	<200412281421.49044.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 14:21:49 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> Well, it kind of does... I mean if register dump is somehow requested 
> from outside of interrupt context then you'll get dump of the next hard
> IRQ. The same goes for softirqs I guess.

Oh yes, that's right.  I remember one of the USB host controller
driver authors wanting to do URB processing in softirq context
and he couldn't because of the input layer using the pt_regs.
