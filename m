Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTFPUvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTFPUvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:51:54 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:15626 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264272AbTFPUvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:51:53 -0400
Date: Mon, 16 Jun 2003 22:05:27 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [BUG] 2.5.71: no cursor until tty output
In-Reply-To: <20030616190042.F13312@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306162152120.26878-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There appears to be a bug in fbcon where the soft cursor does not appear
> on the screen until some tty output occurs.  I suspect soft cursor is
> missing some initialisation somewhere; I have once seen some random garbage
> flashing on the screen instead of the cursor, which seems to be where
> the cursor is supposed to be.
> 
> When tty output occurs, the characters appear where the garbage was, and
> the normal cursor appears.
> 
> I've noticed this on several fbcon drivers, so I don't believe it is a
> generic fbcon bug.

I know which bug you are talking about. I have a fix already in the BK 
tree. Softcursor.c uses the image drawing function. Unfortunely 
softcursor.c assumes that imageblit always process 8 bit padded data. This 
is not always the case. I noticed this with the rivafb driver. I have a 
fix in the fbdev BK tree. A few more bugs need to be fixed tho for the 
software cursor :-( They are coming.



