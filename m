Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFVOZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFVOZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFVOZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:25:35 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:34170 "EHLO
	relay2.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S261304AbVFVOYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:24:46 -0400
From: Alexander Zarochentsev <zam@namesys.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: reiser4 plugins
Date: Wed, 22 Jun 2005 18:24:32 +0400
User-Agent: KMail/1.8
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com>
In-Reply-To: <42B8BB5E.8090008@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506221824.32995.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (248/050617)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0129], SpamtestISP/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 05:14, Jeff Garzik wrote:
> Hans Reiser wrote:
> > Christoph,
> >
> > Reiser4 users love the plugin concept, and all audiences which have
> > listened to a presentation on plugins have been quite positive about
> > it.  Many users think it is the best thing about reiser4.  Can you
> > articulate why you are opposed to plugins in more detail?  Perhaps you
> > are simply not as familiar with it as the audiences I have presented
> > to.  Perhaps persons on our mailing list can comment.....
> >
> > In particular, what is wrong with having a plugin id associated with
> > every file, storing the pluginid on disk in permanent storage in the
> > stat data, and having that plugin id define the set of methods that
> > implement the vfs operations associated with a particular file, rather
> > than defining VFS methods only at filesystem granularity?
>
> You're basically implementing another VFS layer inside of reiser4, which
> is a big layering violation.

Reiser4 suggests a bit more file types than VFS is aware of. I don't even 
think VFS should be.  It is enough that VFS allows each inode/file/dentry  to 
behave own way.  IIRC VFS object's ->foo_ops is for that.   

Reiser plugins are for the same.  Would you agree with reiser4 plugin design 
if the plugins will not dispatch VFS object methods calls by themselves but 
set ->foo_ops fileds instead?  I guess you don't like to have the two 
dispatching systems at the same level.

> This sort of feature should -not- be done at the low-level filesystem
> level.
>
> What happens if people decide plugins are a good idea, and they want
> them in ext3?  We need massive surgery to extract the guts from reiser4.if 
>
> 	Jeff

Thanks,
Alex

