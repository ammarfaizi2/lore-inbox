Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUBJTRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbUBJTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:17:15 -0500
Received: from ns.suse.de ([195.135.220.2]:21954 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265999AbUBJTRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:17:12 -0500
Date: Fri, 13 Feb 2004 00:23:58 +0100
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: torvalds@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-Id: <20040213002358.1dd5c93a.ak@suse.de>
In-Reply-To: <20040210173738.GA9894@mail.shareable.org>
References: <1076384799.893.5.camel@gaston>
	<Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
	<20040210173738.GA9894@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 17:37:38 +0000
Jamie Lokier <jamie@shareable.org> wrote:

 
> The real question is - why does malloc() break?  I'd expect malloc()
> to use MAP_ANON these days, when brk() fails.  But it seems not.

Yep, that's the real bug.

-Andi
