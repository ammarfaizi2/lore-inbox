Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTAULE5>; Tue, 21 Jan 2003 06:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTAULE4>; Tue, 21 Jan 2003 06:04:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39892 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267038AbTAULEz>;
	Tue, 21 Jan 2003 06:04:55 -0500
Date: Tue, 21 Jan 2003 03:03:14 -0800 (PST)
Message-Id: <20030121.030314.41949353.davem@redhat.com>
To: maxk@qualcomm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
References: <Pine.LNX.4.33.0301020341140.2038-100000@champ.qualcomm.com>
	<Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Max Krasnyansky <maxk@qualcomm.com>
   Date: Sun, 19 Jan 2003 19:22:44 -0800 (PST)
   
   The only reason to do module refcounting in sk is if protocol
   changes default callbacks  (i.e. sk->data_ready, etc).

What about the reference to skb->sk?  Are you sure there are
no cases where:

1) skb->sk will be non-NULL
2) default callbacks are used

?
