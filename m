Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWDYUig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWDYUig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDYUig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:38:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932302AbWDYUif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:38:35 -0400
Date: Tue, 25 Apr 2006 13:38:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com
Subject: Re: [PATCH 3/3] Assert notifier_block and notifier_call are not in
 init section
In-Reply-To: <Pine.LNX.4.44L0.0604251624430.839-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.64.0604251336090.3701@g5.osdl.org>
References: <Pine.LNX.4.44L0.0604251624430.839-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Apr 2006, Alan Stern wrote:
> 
> What about loadable modules?  Is their code never loaded into memory that
> used to be part of an init section?

Their code might _physically_ reside in a re-allocation of an init 
section, but will have a virtual address far away (and it would be the 
virtual address that you'd see if you took the address of a function).

		Linus
