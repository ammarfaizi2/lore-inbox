Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030787AbVKIWBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030787AbVKIWBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030788AbVKIWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:01:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030787AbVKIWBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:01:09 -0500
Date: Wed, 9 Nov 2005 14:00:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 2/4] relayfs: Documentation for non-relay file support
Message-Id: <20051109140055.1c83abae.akpm@osdl.org>
In-Reply-To: <17266.28445.60709.667841@tut.ibm.com>
References: <17266.28445.60709.667841@tut.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi <zanussi@us.ibm.com> wrote:
>
>  +relay_open() automatically creates files in the relayfs filesystem to
>  +represent the per-cpu kernel buffers; it's often useful for
>  +applications to be able to create their own files in the relayfs
>  +filesystem as well e.g. 'control' files used to communicate control
>  +information between the kernel and user sides of a relayfs
>  +application.

What are the semantics of these control files?  How does an application
know that there's something new to be read from them?  select() or poll()
or blocking read()?

Can userspace write to the control files?   If so, what happens in-kernel?
