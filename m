Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTKVJc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 04:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTKVJc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 04:32:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:48084 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262130AbTKVJc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 04:32:58 -0500
From: Juergen Hasch <lkml@elbonia.de>
To: Christoph Hellwig <hch@infradead.org>, Michael Welles <mike@bangstate.com>
Subject: Re: Using get_cwd inside a module.
Date: Sat, 22 Nov 2003 10:33:34 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <3FBEA83B.1060001@bangstate.com> <20031122083035.A30106@infradead.org>
In-Reply-To: <20031122083035.A30106@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311221033.35108.lkml@elbonia.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:464ad01b81b0f762cd239ce6f3ab8323
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 22. November 2003 09:30 schrieb Christoph Hellwig:
> The basic problem is that you shouldn't call syscalls from kernelspace.
> Have you looked at dnotify to look for changed files instead?

Dnotify doesn't return the file names that changed, changedfiles does.
I've looked into this, because Samba would benefit from such a functionality.

So maybe it would be possible to teach dnotify to return file names
(e.g. using netlink) ?

...Juergen

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

