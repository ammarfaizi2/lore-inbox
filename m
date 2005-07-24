Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVGXKr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVGXKr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 06:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVGXKr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 06:47:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:52688 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261287AbVGXKr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 06:47:57 -0400
From: Andreas Gruenbacher <agruen@suse.de>
To: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - fix infamous "Busy inodes after umount ..." message.
Date: Sun, 24 Jul 2005 12:48:28 +0200
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Jeff Moyer <jmoyer@redhat.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Edwards <edwardsg@sgi.com>, Greg Banks <gnb@sgi.com>
References: <Pine.LNX.4.63.0507241000120.2330@donald.themaw.net>
In-Reply-To: <Pine.LNX.4.63.0507241000120.2330@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507241248.29501.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sunday 24 July 2005 04:12, Ian Kent wrote:
> If the automount daemon receives a signal which causes it to sumarily
> terminate the autofs4 module leaks dentries. The same problem exists with
> detached mount requests without the warning.
>
> This patch cleans these dentries at umount.

thanks for working on this. For credits, SGI reported this bug, helped with 
debugging, and verified the fix.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
