Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbUKLVkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbUKLVkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbUKLVgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:36:47 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:21184
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262554AbUKLVgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:36:32 -0500
Date: Fri, 12 Nov 2004 13:20:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Godse, Radheka" <radheka.godse@intel.com>
Cc: bonding-devel@lists.sourceforge.net, fubar@us.ibm.com,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Message-Id: <20041112132050.45b83434.davem@davemloft.net>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470823F9A6@orsmsx401.amr.corp.intel.com>
References: <F760B14C9561B941B89469F59BA3A8470823F9A6@orsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004 13:31:53 -0800
"Godse, Radheka" <radheka.godse@intel.com> wrote:

> I had similar thoughts but then, the bond device does not have any
> slaves attached to it at load time. By publishing them upfront the bond
> device is able to take advantage of hardware acceleration if it is later
> available...

This is not a problem at all.

You can make ethtool calls on the bonding device to change
settings later.  Nothing prevents you from changing the
SG/CSUM/TSO bits after device registration.

