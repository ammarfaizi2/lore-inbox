Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUJRUXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUJRUXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUJRUW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:22:27 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:58506
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267170AbUJRUWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:22:03 -0400
Date: Mon, 18 Oct 2004 13:16:53 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Oleg Makarenko <mole@quadra.ru>
Cc: jmorris@redhat.com, Matt_Domsch@dell.com, linux-kernel@vger.kernel.org
Subject: Re: using crypto_digest() on non-kmalloc'd memory failures
Message-Id: <20041018131653.5ac00165.davem@davemloft.net>
In-Reply-To: <41742215.8020005@quadra.ru>
References: <Xine.LNX.4.44.0410181534180.24062-100000@thoron.boston.redhat.com>
	<41742215.8020005@quadra.ru>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 00:05:41 +0400
Oleg Makarenko <mole@quadra.ru> wrote:

> So to calculate digest on some static data I need to copy them to 
> kmalloc'ed memory first, right?
> 
> Can this copying be somehow avoided?

It is necessary to be able to kmap() the data item
passed into the crypto layer, so dynamically allocated
memory obtained via kmalloc() or similar must be used.
