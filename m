Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbTBRDvk>; Mon, 17 Feb 2003 22:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTBRDvk>; Mon, 17 Feb 2003 22:51:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26549 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267578AbTBRDvj>;
	Mon, 17 Feb 2003 22:51:39 -0500
Date: Mon, 17 Feb 2003 19:46:12 -0800 (PST)
Message-Id: <20030217.194612.131926469.davem@redhat.com>
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


After talking to Alexey, I don't like this patch.

The new module subsystem was supposed to deal with things
like this cleanly, and this patch is merely a hack to cover
up for it's shortcomings.

To be honest, I'd rather just disallow module unloading or
let them stay buggy than put this hack into the tree.

Special hacks are for 2.4.x where things like full cleanups
are not allowed.
