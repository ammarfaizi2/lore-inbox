Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269157AbUJFR4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269157AbUJFR4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUJFR4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:56:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:43164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269157AbUJFR4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:56:35 -0400
Date: Wed, 6 Oct 2004 10:56:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Corey Thomas <corey@world.std.com>
cc: netdev@oss.sgi.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Raylink/WebGear testing - ray_cs.c iomem bug?
In-Reply-To: <Pine.LNX.4.58.0410061032410.8290@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410061053550.8290@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410061032410.8290@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Oct 2004, Linus Torvalds wrote:
> 
> If somebody has access to this card and can test it, can you email me? I'd 
> hate to apply even an "obvious" fix when the bug may be hidden by other 
> bugs, and the obvious fix might end up breaking things for silly reasons.

Ahh. Never mind. It looks like the RCS/CCS difference is encoded in the 
index that is used to offset the base, which means that rcs_base and 
ccs_base really do end up being the same thing.

Still, I'd love to have somebody verify that the cleaned-up version 
(without any changes) still works. It should be 100% equivalent to the old 
one, but it's good to make sure.

		Linus
