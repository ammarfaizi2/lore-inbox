Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUHBUJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUHBUJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUHBUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:09:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262905AbUHBUJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:09:09 -0400
Date: Mon, 2 Aug 2004 13:07:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: kiran@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       greg@kroah.com, dipankar@in.ibm.com
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-Id: <20040802130729.2dae8fd5.davem@redhat.com>
In-Reply-To: <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
	<20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004 17:56:07 +0100
viro@parcelfarce.linux.theplanet.co.uk wrote:

> How about this for comparison?  That's just a dumb "convert to rwlock"
> patch; we can be smarter in e.g. close_on_exec handling, but that's a
> separate story.

Compares to plain spinlocks, rwlock's don't buy you much,
if anything, these days.

Especially for short sequences of code.
