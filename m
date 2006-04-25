Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWDYU0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWDYU0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWDYU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:26:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57257 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932284AbWDYU0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:26:14 -0400
Date: Tue, 25 Apr 2006 16:26:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <herbert@13thfloor.at>,
       <linux-xfs@oss.sgi.com>, <xfs-masters@oss.sgi.com>
Subject: Re: [PATCH 3/3] Assert notifier_block and notifier_call are not in
 init section
In-Reply-To: <Pine.LNX.4.64.0604251211510.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0604251624430.839-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006, Linus Torvalds wrote:

> > 2) Unrelated to this patch: If the _code_ section is never reallocated
> > or reused, what is the purpose of putting _code_ in the init section ?
> > Only to make sure that the init calls are called in order ?
> 
> No, the code section is re-used, it's just never re-used for any other 
> code (since we don't generate code on the fly). So if you pass in a 
> function pointer, you know that if it's in the init section, it means that 
> init-code that was discarded.

What about loadable modules?  Is their code never loaded into memory that
used to be part of an init section?

Alan Stern

