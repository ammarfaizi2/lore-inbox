Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTEJTLY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTEJTLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:11:23 -0400
Received: from terminus.zytor.com ([63.209.29.3]:61059 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S264473AbTEJTLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:11:19 -0400
Message-ID: <3EBD51C6.8030100@zytor.com>
Date: Sat, 10 May 2003 12:23:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
References: <20030509124042.GB25569@mail.jlokier.co.uk> <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com> <b9hrhg$5v7$1@cesium.transmeta.com> <20030510153156.GA29271@mail.jlokier.co.uk>
In-Reply-To: <20030510153156.GA29271@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> It doesn't need a PTE.  The vsyscall code could be _copied_ to the end
> of the page at 0xbffff000, with the stack immediately preceding it.
> 

You don't really want that, though.  If you're doing gettimeofday() in 
user space it's critically important that the kernel can modify all 
these pages at once.

	-hpa

