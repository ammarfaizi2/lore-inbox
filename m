Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759712AbWLEVva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759712AbWLEVva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759753AbWLEVva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:51:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36158 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759710AbWLEVv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:51:28 -0500
Date: Tue, 5 Dec 2006 13:50:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com
Subject: Re: [PATCH 21/35] Unionfs: Inode operations
Message-Id: <20061205135017.3be94142.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0612052222190.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
	<11652354711835-git-send-email-jsipek@cs.sunysb.edu>
	<Pine.LNX.4.61.0612052222190.18570@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 22:27:10 +0100 (MET)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> 
> On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
> >+	if (!hidden_dentry) {
> >+		/* if hidden_dentry is NULL, create the entire
> >+		 * dentry directory structure in branch 'bindex'.
> >+		 * hidden_dentry will NOT be null when bindex == bstart
> >+		 * because lookup passed as a negative unionfs dentry
> >+		 * pointing to a lone negative underlying dentry */
> >+		hidden_dentry = create_parents(parent, dentry, bindex);
> 
> Someone refresh me: what's the correct[preferred] kdoc style?

This isn't part of kernel-doc, if that's what you mean.

> (A)
> 	/* Lorem ipsum dolor sit amet, consectetur
> 	 * adipisicing elit, sed do eiusmod tempor
> 	 * incididunt ut labore et dolore magna aliqua. */
> 
> (B)
> 	/* Lorem ipsum dolor sit amet, consectetur
> 	   adipisicing elit, sed do eiusmod tempor
> 	   incididunt ut labore et dolore magna aliqua. */
> 
> (C)
> 	/* Lorem ipsum dolor sit amet, consectetur
> 	adipisicing elit, sed do eiusmod tempor incididunt
> 	ut labore et dolore magna aliqua. */

You forgot (D), (E), (F), (G) and a whole lot more besides.

It doesn't matter a lot what we do, but we should do it one way and not 38
ways.

Documentation/CodingStyle doesn't mention commenting at all (eyes roll
heavenwards).

This

	/*
	 * Lorem ipsum dolor sit amet, consectetur
	 * adipisicing elit, sed do eiusmod tempor
	 * incididunt ut labore et dolore magna aliqua.
	 */

is probably the most common, and is what I use when forced to descrog
comments.
