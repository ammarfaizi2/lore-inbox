Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTBGJwh>; Fri, 7 Feb 2003 04:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTBGJwg>; Fri, 7 Feb 2003 04:52:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17884 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267771AbTBGJwg>;
	Fri, 7 Feb 2003 04:52:36 -0500
Date: Fri, 07 Feb 2003 01:48:36 -0800 (PST)
Message-Id: <20030207.014836.78483470.davem@redhat.com>
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

   So here is new patch.

Ok, it generally looks fine, and try_module_get() is cheap enough
(basically the equivalent of a local-cpu statistic bump plus
a compare) that I'm not concerned about any added overhead.

And since it is fixing a bug... :-)

Just let me discuss some things with Alexey before I apply this.
