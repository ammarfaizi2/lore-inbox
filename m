Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268055AbTAIXxi>; Thu, 9 Jan 2003 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268056AbTAIXxi>; Thu, 9 Jan 2003 18:53:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15747 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268055AbTAIXxg>;
	Thu, 9 Jan 2003 18:53:36 -0500
Date: Thu, 09 Jan 2003 15:53:26 -0800 (PST)
Message-Id: <20030109.155326.46433564.davem@redhat.com>
To: maxk@qualcomm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20030109124152.07a18e28@mail1.qualcomm.com>
References: <Pine.LNX.4.33.0212252340090.1270-100000@champ.qualcomm.com>
	<20030107.012139.34126482.davem@redhat.com>
	<5.1.0.14.2.20030109124152.07a18e28@mail1.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Max Krasnyansky <maxk@qualcomm.com>
   Date: Thu, 09 Jan 2003 12:45:37 -0800

   Those guys will have to bump mod refcount themselves then.
   sock_init_data() and sock_graft() have access to ->owner field but sk_alloc()
   doesn't. So we either have to change sk_alloc() API or make call to
   sock_init_data()/sock_graft() a must. Any other suggestions ?

This isn't rocket science, just make a new sock_foo() interface
that merely does the module owner setup.
