Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVCWVaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVCWVaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVCWV3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:29:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261974AbVCWV26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:28:58 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050323130724.1aacfcf3.akpm@osdl.org> 
References: <20050323130724.1aacfcf3.akpm@osdl.org>  <29204.1111608899@redhat.com> <29285.1111609185@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mahalcro@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Keys: Use RCU to manage session keyring pointer 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Mar 2005 21:28:51 +0000
Message-ID: <30373.1111613331@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote:

> David Howells <dhowells@redhat.com> wrote:
> >
> > The attached patch uses RCU to manage the session keyring pointer in struct
> >  signal_struct.
> 
> So are these patches dependent upon the
> keys-use-rcu-to-manage-session-keyring-pointer work?

This patch (2/3) shouldn't be dependent on that. It does extra RCU-age on a
different pointer entirely. The other RCU-age patch deals with specific key
types.

However, the third patch adds extra stuff into keyring support, and so is
RCU'd keyrings dependent.

David
