Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbTFMMYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 08:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTFMMYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 08:24:43 -0400
Received: from nef.ens.fr ([129.199.96.32]:29190 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S265366AbTFMMYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 08:24:42 -0400
Date: Fri, 13 Jun 2003 14:38:27 +0200 (MET DST)
From: Vincent Fourmond <fourmond@clipper.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Kernel comile problem
Message-ID: <Pine.SOL.4.44.0306131422120.22593-100000@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello !

  I have encountered few troubles while compiling the 2.4.20-7 debian
(testing) version of teh Linux Kernel. I got one compiling error

ide-cd.h:440: error: long, short, signed or unsigned used invalidly for
`slot_tablelen'

  Which I corrected by commenting out "short"

        __u8 /*short*/ slot_tablelen;

  And during the linking

net/network.o(.text+0xd577): In function `rtnetlink_rcv':
: undefined reference to `rtnetlink_rcv_skb'

  which I corrected by commenting out the "inline" stuff in the file
net/core/rtnetlink.c line 397

/*extern __inline__*/ int rtnetlink_rcv_skb(struct sk_buff *skb)

  It looks like it does work, but I guess it is not normal ! Is there
actually anything to be done about this ?

	Vincent Fourmond



