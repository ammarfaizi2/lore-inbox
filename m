Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTIEAuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTIEAuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:50:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:63373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbTIEAuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:50:03 -0400
Date: Thu, 4 Sep 2003 17:49:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix remap of shared read only mappings
In-Reply-To: <200309050249.21152.phillips@arcor.de>
Message-ID: <Pine.LNX.4.44.0309041748290.13736-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Sep 2003, Daniel Phillips wrote:
>
> This an interesting tidbit, as I'm busy working on a DFS mmap for OpenGFS, and 
> I want to be sure I'm implementing true-blue Posix semantics.

Please don't.

POSIX semantics are weak enough not to be interesting. Exactly because a 
number of old hardware platforms simply _cannot_ give you good coherency. 
And a number of old UNIXes couldn't either, for that matter.

What really matters is that mmap() under Linux is 100% coherent, as far as 
the hardware just allows. We haven't taken the easy way out. We shouldn't 
start now.

		Linus

