Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWBLXKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWBLXKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBLXKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:10:47 -0500
Received: from mail.gmx.net ([213.165.64.21]:8576 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751067AbWBLXKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:10:46 -0500
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: Jeff Mahoney <jeffm@suse.com>
Subject: Re: 2.6.15 Bug? New security model?
Date: Mon, 13 Feb 2006 00:10:40 +0100
User-Agent: KMail/1.9.1
Cc: Sergey Vlasov <vsu@altlinux.ru>, Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
References: <200602080212.27896.bernd-schubert@gmx.de> <20060212005541.107f7011.vsu@altlinux.ru> <20060212175740.GB8805@locomotive.unixthugs.org>
In-Reply-To: <20060212175740.GB8805@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602130010.41027.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is essentially code-introduced corruption. The patch to fix it in
> future versions is easy enough, but you'll need to run reiserfsck
> --clean-attributes <device> on any affected file systems.
>
> Bernd - If you haven't already run reiserfsck --clean-attributes on the fs,
> can you please test the attached patch? It adds a check to make sure the
> file system has always been v3.6 before enabling the attributes by default.

With attrs defaulting to on I don't think 'reiserfsck --clean-attributes' can 
be the solution. There are just too many filesystems that are affected. So 
for now I also won't clean up the attributes ;)
Since Sergey already proved that directories always have the old format, I 
didn't test your patch, but tried Sergeys patch.

Thanks for all of your help,
	Bernd


