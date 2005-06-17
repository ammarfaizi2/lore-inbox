Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVFQSiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVFQSiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVFQSiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:38:09 -0400
Received: from peabody.ximian.com ([130.57.169.10]:11419 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262052AbVFQSiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:38:04 -0400
Subject: Re: [patch] inotify.
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050617182826.GA20250@infradead.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175404.GA19463@infradead.org> <1119032213.3949.124.camel@betsy>
	 <20050617182826.GA20250@infradead.org>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 14:38:06 -0400
Message-Id: <1119033486.3949.135.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 19:28 +0100, Christoph Hellwig wrote:

> You are using ioctl as an really bad syscall multiplexer.  You're
> not using the file descriptor it's called on at all, so it does not qualify
> as a valid ioctl() usage even under the most lax rules.

We provide two different ioctl commands, it is not a bad multiplexer.
We have discussed this before.

We do use the fd.  It maps back to the inotify device.

> Also you claimed the resource shortage for the proposed architecture
> with just a single syscall, aka one watch per fd without showing any
> reasons why that would be true, in fact by any means there's no reason
> to believe file descriptors are a rare ressource in a modern Linux system.

It is not implausible to believe that a system might have the default
maximum for file descriptors (not very high) but allow a _much_ greater
number of inotify watches (32k, say).

That is our rationale.  I hear what you are saying, I understand it, and
at the end of the day I disagree.  I appreciate your input, but I feel
otherwise.

> I don't care whether you adopt my interface proposal or a different passable
> one, but the current one is not acceptable at all.

Everything to you is "really bad" and "totally unacceptable".  Chill
out.  Stop ranting so much and enjoy life.

	Robert Love


