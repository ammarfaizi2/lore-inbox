Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbUKDTqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbUKDTqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUKDTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:46:31 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63192
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262410AbUKDTnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:43:07 -0500
Date: Thu, 4 Nov 2004 11:32:19 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Robert Love <rml@novell.com>
Cc: greg@kroah.com, anton@samba.org, linux-kernel@vger.kernel.org,
       davem@redhat.com, herbert@gondor.apana.org.au, kay.sievers@vrfy.org
Subject: Re: netlink vs kobject_uevent ordering
Message-Id: <20041104113219.10770b35.davem@davemloft.net>
In-Reply-To: <1099592033.31022.138.camel@betsy.boston.ximian.com>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
	<20041104180550.GA16744@kroah.com>
	<1099592033.31022.138.camel@betsy.boston.ximian.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004 13:13:53 -0500
Robert Love <rml@novell.com> wrote:

> On Thu, 2004-11-04 at 10:05 -0800, Greg KH wrote:
> 
> > So, Robert and Kay, any thoughts as to how this has ever worked at boot
> > time in the past?
> 
> Weird.  I don't have a clue, but clearly it did work.

It might have really failing recently because nl_table in
net/netlink/af_netlink.c has become dynamically allocated
memory setup by netlink_proto_init().
