Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVBNQA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVBNQA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVBNQAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:00:25 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:25247
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261456AbVBNQAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:00:21 -0500
Date: Mon, 14 Feb 2005 07:56:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       michal@logix.cz, adam@yggdrasil.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050214075655.6dec60cb.davem@davemloft.net>
In-Reply-To: <1108387234.8086.37.camel@ghanima>
References: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
	<1108387234.8086.37.camel@ghanima>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005 14:20:34 +0100
Fruhwirth Clemens <clemens@endorphin.org> wrote:

> Conclusion: The idea of high-mem and low-mem seperation is fundamentally
> broken. The limitation of page table entries to a fixed set is causing
> more complications than it solves. Laziness to do things right at memory
> management shifts the burden to the users of the interface. 

Doing it "at memory management" is what many other OS's do and
is incredibly costly especially on SMP systems.  Please ponder
those issues for some time before you blast Linux's MM design
decisions.  They were not made in a vacuum.

I used to be heavily against this scheme long ago, but over time
I've seen more and more how it's the right thing to do.

