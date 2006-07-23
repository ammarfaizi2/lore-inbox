Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWGWT0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWGWT0a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 15:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWGWT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 15:26:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:35782 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751273AbWGWT03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 15:26:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=N6lQFvLWTA2WjVWQTYjnxs9MrvdRml32FKOWH8pzo7EQsp2Bp+mhlDWRf135tLMduQNkXhQg9hukU29mysYGgORGwAygx1JA/Q/EObOVcqr8x4JnhnYvRT+//ONkRV3E7zCUGFEmYILqspnFaaTMReyVGqoUW/xIgWhcJzM0Pio=
Date: Sun, 23 Jul 2006 23:26:26 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       James Morris <jmorris@redhat.com>, Nathan Scott <nathans@debian.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: include/linux/xattr.h: how much userpace visible?
Message-ID: <20060723192626.GA6815@martell.zuzino.mipt.ru>
References: <20060723184343.GA25367@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060723184343.GA25367@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2006 at 08:43:43PM +0200, Adrian Bunk wrote:
> how much of include/linux/xattr.h has to be part of the userspace kernel
> headers?
>
> The function prototypes should no longer be visible in userspace.
> But how much of the rest of this file is usable for userspace?

XATTR_CREATE, XATTR_REPLACE are passed to sys_setxattr syscall.
struct xattr_handler is ours (it uses struct inode *). Prototypes are
ours.

