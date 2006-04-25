Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWDYUwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWDYUwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWDYUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:52:12 -0400
Received: from xenotime.net ([66.160.160.81]:56290 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751265AbWDYUwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:52:12 -0400
Date: Tue, 25 Apr 2006 13:54:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: stern@rowland.harvard.edu, sekharan@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com
Subject: Re: [PATCH 3/3] Assert notifier_block and notifier_call are not in
 init section
Message-Id: <20060425135436.5f4c51fd.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0604251336090.3701@g5.osdl.org>
References: <Pine.LNX.4.44L0.0604251624430.839-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0604251336090.3701@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 13:38:22 -0700 (PDT) Linus Torvalds wrote:

> 
> 
> On Tue, 25 Apr 2006, Alan Stern wrote:
> > 
> > What about loadable modules?  Is their code never loaded into memory that
> > used to be part of an init section?
> 
> Their code might _physically_ reside in a re-allocation of an init 
> section, but will have a virtual address far away (and it would be the 
> virtual address that you'd see if you took the address of a function).

and the freed init data area is poisoned (in 386, x86_64, powerpc, and
sparc64).

---
~Randy
