Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTIWV2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTIWV2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:28:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:40881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263440AbTIWV2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:28:14 -0400
Date: Tue, 23 Sep 2003 14:28:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Deepak Saxena <dsaxena@mvista.com>
cc: linux-kernel@vger.kernel.org, <marcelo.tosatti@cyclades.com.br>
Subject: Re: [PATCH] Fix %x parsing in vsscanf()
In-Reply-To: <20030923212207.GA25234@xanadu.az.mvista.com>
Message-ID: <Pine.LNX.4.44.0309231421450.24527-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Sep 2003, Deepak Saxena wrote:
> 
> Another option is to put the check in simple_strtoul() and
> simple_strtoull() if that is preferred. I like this better b/c
> we only have the check once.

I'd much rather fix strtoul[l](). In fact, strtoul[l]()  _already_ accepts
the "0x" prefix - but it only does so if the "base" parameter is 0.

Fixing strtoul[l] should fix vsscanf() automatically, no? So I don't see 
the "have the check only once" argument.

		Linus

