Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUDUU1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUDUU1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUDUU1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:27:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27821 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263679AbUDUU1D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:27:03 -0400
Date: Wed, 21 Apr 2004 13:20:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: cfriesen@nortelnetworks.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Message-Id: <20040421132047.026ab7f2.davem@redhat.com>
In-Reply-To: <20040421170340.GB24201@wohnheim.fh-wedel.de>
References: <40869267.30408@nortelnetworks.com>
	<Pine.LNX.4.53.0404211153550.1169@chaos>
	<4086A077.2000705@nortelnetworks.com>
	<20040421170340.GB24201@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004 19:03:40 +0200
Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Heise.de made it appear, as if the only news was that with tcp
> windows, the propability of guessing the right sequence number is not
> 1:2^32 but something smaller.  They said that 64k packets would be
> enough, so guess what the window will be.

Yes, that is their major discovery.  You need to guess the ports
and source/destination addresses as well, which is why I don't
consider this such a serious issue personally.

It is mitigated if timestamps are enabled, because that becomes
another number you have to guess.

It is mitigated also by randomized ephemeral port selection, which
OpenBSD implements and we could easily implement as well.

I'm very happy that OpenBSD checked in a fix for this a week or so
ago and took some of the thunder out of this bogusly hyped announcement.
