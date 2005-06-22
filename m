Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVFVBOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVFVBOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVFVBOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:14:23 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25002 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262450AbVFVBOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:14:19 -0400
Message-ID: <42B8BB5E.8090008@pobox.com>
Date: Tue, 21 Jun 2005 21:14:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>
In-Reply-To: <42B8B9EE.7020002@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Christoph,
> 
> Reiser4 users love the plugin concept, and all audiences which have
> listened to a presentation on plugins have been quite positive about
> it.  Many users think it is the best thing about reiser4.  Can you
> articulate why you are opposed to plugins in more detail?  Perhaps you
> are simply not as familiar with it as the audiences I have presented
> to.  Perhaps persons on our mailing list can comment.....
> 
> In particular, what is wrong with having a plugin id associated with
> every file, storing the pluginid on disk in permanent storage in the
> stat data, and having that plugin id define the set of methods that
> implement the vfs operations associated with a particular file, rather
> than defining VFS methods only at filesystem granularity?

You're basically implementing another VFS layer inside of reiser4, which 
is a big layering violation.

This sort of feature should -not- be done at the low-level filesystem level.

What happens if people decide plugins are a good idea, and they want 
them in ext3?  We need massive surgery to extract the guts from reiser4.

	Jeff



