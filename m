Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVCWWtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVCWWtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVCWWtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:49:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262366AbVCWWtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:49:22 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050323143405.502c1c84.akpm@osdl.org> 
References: <20050323143405.502c1c84.akpm@osdl.org>  <20050323130628.3a230dec.akpm@osdl.org> <29204.1111608899@redhat.com> <30327.1111613194@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mahalcro@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Keys: Pass session keyring to call_usermodehelper() 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Mar 2005 22:49:07 +0000
Message-ID: <31726.1111618147@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Well one question is "does it make sense to make a keyring session a part
> of the call_usermodehelper() API?".  As it appears that only one caller
> will ever want to do that then I'd say no, and that it should be some
> specialised thing private to the key code and the call_usermodehelper()
> implementation.
> 
> So unless you think that a significant number of callers will appear who
> are actually using the new capability then it would be better to keep the
> existing call_usermodehelper() API.

That's a good question, and one that's not easy to answer. Obviously, at the
moment there will only be that one user. I'm not sure that other users will
necessarily want to make use of it.

On the other hand, I can see the authorisation key bit being extended to
provide all of these things with access to the authorising process's keyrings,
whether or not they're constructing keys; but that can probably be made
transparent.

David
