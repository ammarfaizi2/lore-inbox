Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269284AbUIHS0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269284AbUIHS0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbUIHS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:26:47 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:38856
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269284AbUIHSYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:24:54 -0400
Date: Wed, 8 Sep 2004 11:21:43 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: jbarnes@engr.sgi.com, willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: multi-domain PCI and sysfs
Message-Id: <20040908112143.330a9301.davem@davemloft.net>
In-Reply-To: <9e47339104090723554eb021e4@mail.gmail.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	<200409072115.09856.jbarnes@engr.sgi.com>
	<20040907211637.20de06f4.davem@davemloft.net>
	<200409072125.41153.jbarnes@engr.sgi.com>
	<9e47339104090723554eb021e4@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004 02:55:15 -0400
Jon Smirl <jonsmirl@gmail.com> wrote:

> Another part I don't understand... PCI VGA hardware is designed to
> respond to IN/OUT instructions to port space. ppc64/ia64 don't have
> IN/OUT port instructions.

On ppc, sparc, and other non-x86 platforms, when you perform load/store
instructions within the port I/O space window, the PCI controller emits
the IN/OUT transactions exactly as if an x86 processor had executed
an in{bwl}/out{bwl} instruction.
