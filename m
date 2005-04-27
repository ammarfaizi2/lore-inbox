Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVD0P7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVD0P7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVD0P7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:59:09 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:3493 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261772AbVD0P5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:57:36 -0400
To: dedekind@infradead.org
CC: linux-kernel@vger.kernel.org, dwmw2@infradead.org, viro@math.psu.edu,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	(dedekind@infradead.org)
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without clear_inode()
	call between
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
Message-Id: <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 17:57:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Comments?
> 

On second thought a wake_up_inode() seems to be missing in
dispose_list() just before destroy_inode().  

Also I'm not sure delaying removal from i_sb_list is the right thing.
generic_delete_inode() does this before clear_inode().

Miklos
