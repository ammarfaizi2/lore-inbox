Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVA1U7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVA1U7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVA1U5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:57:00 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:34251
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262744AbVA1UuH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:50:07 -0500
Date: Fri, 28 Jan 2005 12:45:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       netdev@oss.sgi.com, arjan@infradead.org, hlein@progressive-comp.com
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-Id: <20050128124517.36aa5e05.davem@davemloft.net>
In-Reply-To: <1106944492.3864.30.camel@localhost.localdomain>
References: <1106932637.3778.92.camel@localhost.localdomain>
	<20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	<1106937110.3864.5.camel@localhost.localdomain>
	<20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	<1106944492.3864.30.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 21:34:52 +0100
Lorenzo Hernández García-Hierro <lorenzo@gnu.org> wrote:

> Attached the new patch following Arjan's recommendations.

No SMP protection on the SBOX, better look into that.
The locking you'll likely need to add will make this
routine serialize many networking operations which is
one thing we've been trying to avoid.
