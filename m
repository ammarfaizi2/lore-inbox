Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUCWCba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUCWCba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:31:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262128AbUCWCb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:31:28 -0500
Date: Mon, 22 Mar 2004 18:31:26 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Issues with /proc/bus/pci
Message-Id: <20040322183126.16fe76cc.davem@redhat.com>
In-Reply-To: <1080007613.22212.61.camel@gaston>
References: <1080007613.22212.61.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 13:06:53 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I could add the host bridge thing fairly easily, but I think it
> is not very practical. Well, I probably have to add it anyway in
> case any existing stuff uses that, but it's definitely not
> practical when you have a bit of useralnd that knows the PCI ID
> (domain/bus/devfn) of the card and wants to access the legacy IO
> space of that bridge. The problem is finding which pci_dev is
> the host bridge, if any since host bridges aren't required to
> show up at all.

You have a problem.  You must implement this 'trick' because things
like xfree86 domain stuff wants it too.

I've been exporting the host PCI bridges to the usespace since day one,
and one only needs walk the devfn/bus numbers properly to find the proper
bridge for a given pci dev, right?
