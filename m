Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUJEUCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUJEUCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJET7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:59:01 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:18056
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S264881AbUJETy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:54:57 -0400
Date: Tue, 5 Oct 2004 12:54:33 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] 2.[46]: Permit the official ARP hw type in
 SIOCSARP for FDDI
Message-Id: <20041005125433.3cc516c9.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58L.0410040312500.22545@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.58L.0410040312500.22545@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004 23:57:09 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  The SIOCSARP handling code currently rejects attempts of setting an arp
> entry for FDDI devices if the Ethernet ARP hw type is specified in the
> request.  Using this ARP hw type is mandated by RFC 1390 (STD 36) and I
> think it's reasonable to accept SIOCSARP requests using this type,
> especially as it already works this way for ARP packets received from the
> network.  One reason for this is bootpd setting explicit ARP cache entries
> using the hw type that is also sent to a client.  Here is a patch for both
> 2.4 and 2.6 that fixes the problem for me.  For consistency with code used
> for ARP packets, it makes both Ethernet and IEEE802 ARP hw type acceptable
> for FDDI interfaces.  Please apply.
> 
>  Applies both to 2.4.27 and to 2.6.8.1.

Patch applied, thanks.
