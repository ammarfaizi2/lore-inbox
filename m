Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVCWV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVCWV0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVCWV0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:26:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44969 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261965AbVCWV0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:26:45 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050323130628.3a230dec.akpm@osdl.org> 
References: <20050323130628.3a230dec.akpm@osdl.org>  <29204.1111608899@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mahalcro@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Keys: Pass session keyring to call_usermodehelper() 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Mar 2005 21:26:34 +0000
Message-ID: <30327.1111613194@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote:

> > The attached patch makes it possible to pass a session keyring through to
> >  the process spawned by call_usermodehelper().
> 
> hm.  Seems likely to attract angry emails due to breakage of out-of-tree
> stuff.  Did you consider
> 
> static inline int
> call_usermodehelper(char *path, char **argv, char **envp, int wait)
> {
> 	return call_usermodehelper_keys(path, argv, envp, NULL, wait);
> }

No. I can do that if you want. It seems a bit excessive though.

David
