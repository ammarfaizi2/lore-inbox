Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUHTTsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUHTTsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHTTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:48:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52881 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268005AbUHTTsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:48:51 -0400
Date: Fri, 20 Aug 2004 12:48:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: root@chaos.analogic.com
Cc: adilger@clusterfs.com, jlcooke@certainkey.com, shemminger@osdl.org,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040820124823.071ac1d9.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.53.0408201518250.25319@chaos>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	<20040820175952.GI5806@certainkey.com>
	<20040820185956.GV8967@schnapps.adilger.int>
	<Pine.LNX.4.53.0408201518250.25319@chaos>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 15:22:09 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> The attached code will certainly work on Intel machines. It is
> in the public domain, having been modified by myself to produce
> a very long sequence...

How long a period does it have?  The one we're adding to the
networking has one which is 2^88.

> I wouldn't suggest converting it to 'C' because the rotation
> takes many CPU instructions when one tries to do the test, shift,
> and OR in 'C',

You only need 2 'shifts' and an 'or' to do a rotate in C.
No tests are needed.
