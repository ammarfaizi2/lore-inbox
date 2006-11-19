Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756732AbWKSP7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbWKSP7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 10:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756735AbWKSP7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 10:59:39 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:3216 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1756732AbWKSP7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 10:59:38 -0500
Date: Sun, 19 Nov 2006 16:58:47 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml fails to compile due to missing offsetof
Message-ID: <20061119155847.GA6890@aepfle.de>
References: <20061119120000.GA4926@aepfle.de> <20061119142507.GA3284@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061119142507.GA3284@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, Jeff Dike wrote:

> On Sun, Nov 19, 2006 at 01:00:01PM +0100, Olaf Hering wrote:
> > 
> > I fail to see how arch/um/sys-i386/user-offsets.c can compile since
> > offsetof() was declared __KERNEL__ only in include/linux/stddef.h.
> > Does it work for anyone else? 
> 
> It obviously works for me.  offsetof is very standard C.  I'd venture
> to say that a system which can't find it has a broken gcc installation.

How do you get _STDDEF_H defined in
/usr/lib/gcc/<target>/<vers>/include/stddef.h ?
For me _STDDEF_H remains undefined, and /usr/include/linux/stddef.h has
offsetof inside __KERNEL__.
