Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVCWVKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVCWVKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVCWVJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:09:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:33457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262917AbVCWVG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:06:57 -0500
Date: Wed, 23 Mar 2005 13:06:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, mahalcro@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Keys: Pass session keyring to call_usermodehelper()
Message-Id: <20050323130628.3a230dec.akpm@osdl.org>
In-Reply-To: <29204.1111608899@redhat.com>
References: <29204.1111608899@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch makes it possible to pass a session keyring through to the
>  process spawned by call_usermodehelper().

hm.  Seems likely to attract angry emails due to breakage of out-of-tree
stuff.  Did you consider

static inline int
call_usermodehelper(char *path, char **argv, char **envp, int wait)
{
	return call_usermodehelper_keys(path, argv, envp, NULL, wait);
}

?

