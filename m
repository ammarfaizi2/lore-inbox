Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUIOQ54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUIOQ54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUIOQ5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:57:55 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:407 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266708AbUIOQy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:54:58 -0400
Date: Wed, 15 Sep 2004 18:54:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915165450.GD6158@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 September 2004 09:30:42 -0700, Linus Torvalds wrote:
> 
> For example, if you don't know (or, more importantly - don't care) what 
> kind of IO interface you use, you can now do something like
> 
> 	void __iomem * map = pci_iomap(dev, bar, maxbytes);
> 	...
> 	status = ioread32(map + DRIVER_STATUS_OFFSET);

C now supports pointer arithmetic with void*?  I hope the width of a
void is not architecture dependent, that would introduce more subtle
bugs.

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown
