Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263396AbTCNQhd>; Fri, 14 Mar 2003 11:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263398AbTCNQhd>; Fri, 14 Mar 2003 11:37:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:65475 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263396AbTCNQhc>;
	Fri, 14 Mar 2003 11:37:32 -0500
Date: Fri, 14 Mar 2003 08:45:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: braam@clusterfs.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix stack usage in fs/intermezzo/journal.c
Message-Id: <20030314084536.522ad81c.rddunlap@osdl.org>
In-Reply-To: <20030314164445.GC23161@wohnheim.fh-wedel.de>
References: <20030314155352.GD27154@wohnheim.fh-wedel.de>
	<20030314080930.5ff3cc80.rddunlap@osdl.org>
	<20030314164445.GC23161@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003 17:44:45 +0100 Joern Engel <joern@wohnheim.fh-wedel.de> wrote:

| On Fri, 14 March 2003 08:09:30 -0800, Randy.Dunlap wrote:
| > 
| > I guess one of us needs some guidance here.
| > I thought that sizeof(*buf) == 1 here, not 4096.  Anybody?
| > I don't see how sizeof() can determine the kmalloc-ed size,
| > so I would use BUF_SIZE instead, with
| > #define BUF_SIZE	4096
| 
| I'd love to say you're wrong, but you're not. New patch is below.
| FUNCTION_NAME_BUFSIZE should have less name collision than BUF_SIZE,
| but someone who knows intermezzo better than me might find a much
| nicer name.

If you are concerned about namespace & collisions, you can
#undef BUF_SIZE
after each function.

--
~Randy
