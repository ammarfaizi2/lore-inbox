Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUKPJ4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUKPJ4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUKPJxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:53:33 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:19178 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261368AbUKPJwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:52:50 -0500
To: arjan@infradead.org
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1100598372.2811.21.camel@laptop.fenrus.org> (message from Arjan
	van de Ven on Tue, 16 Nov 2004 10:46:13 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <1100596704.2811.17.camel@laptop.fenrus.org>
	 <E1CTzpJ-0000ap-00@dorka.pomaz.szeredi.hu> <1100598372.2811.21.camel@laptop.fenrus.org>
Message-Id: <E1CU00w-0000cM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 10:52:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> yes but how do you know the entry is still on the list and valid ?

Because, it's always kept on one of two lists: pending and processing.
The entry is valid valid because it's "owned" by the caller, it's
never freed inside request_send().

> you dropped the lock. A normal code pattern is that you then HAVE 
> to revalidate the assumptions which you guard by that lock.

The lock guards the list not the list element which is being removed.

Miklos
