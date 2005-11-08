Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVKHPzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVKHPzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKHPzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:55:43 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:16914 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932308AbVKHPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:55:42 -0500
To: linuxram@us.ibm.com
CC: miklos@szeredi.hu, viro@ftp.linux.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1131464926.5400.234.camel@localhost> (message from Ram Pai on
	Tue, 08 Nov 2005 07:48:46 -0800)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
	 <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu> <1131464926.5400.234.camel@localhost>
Message-Id: <E1EZVoO-000807-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 08 Nov 2005 16:55:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No. As explained in the same earlier threads; without this change the
> behavior of shared-subtrees leads to inconsistency and confusion in some
> scenarios.
> 
> Under the premise that no application should depend on this behavior
> (most-recent-mount-visible v/s top-most-mount-visible),

The strongest argument against was that

  mount foo .; umount .

would no longer be a no-op.

> Al Viro permitted this change. And this is certainly the right
> behavior.

Which is a contradiction in term, since you are saying that
applications _do_ depend on it.

Miklos
