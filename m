Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUKLWky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUKLWky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKLWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:40:53 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:39873
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262648AbUKLWio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:38:44 -0500
Date: Fri, 12 Nov 2004 14:24:58 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: radheka.godse@intel.com, bonding-devel@lists.sourceforge.net,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Message-Id: <20041112142458.51ca5921.davem@davemloft.net>
In-Reply-To: <200411122220.iACMKpjw014426@death.nxdomain.ibm.com>
References: <20041112134918.305379c4.davem@davemloft.net>
	<200411122220.iACMKpjw014426@death.nxdomain.ibm.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004 14:20:51 -0800
Jay Vosburgh <fubar@us.ibm.com> wrote:

> 	Would it be preferrable to duplicate that logic in bonding, or
> push it out to an inline or some such?

It's present also in the ethtool methods used to change
these things, so you might consider making ethtool calls
to change the bits as well.

It's a pretty bad idea for folks to be changing the ->features
bits directly in drivers after device registry.
