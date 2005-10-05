Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVJEAOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVJEAOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 20:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVJEAOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 20:14:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14314 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965046AbVJEAOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 20:14:42 -0400
Date: Wed, 5 Oct 2005 01:14:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: 7eggert@gmx.de
Cc: David Leimbach <leimy2k@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
Message-ID: <20051005001441.GR7992@ftp.linux.org.uk>
References: <4TkbZ-6KJ-9@gated-at.bofh.it> <4U0uy-33E-7@gated-at.bofh.it> <4U0XK-3Gp-47@gated-at.bofh.it> <E1EMuCq-0000yq-Dt@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EMuCq-0000yq-Dt@be1.lrz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 11:20:12PM +0200, Bodo Eggert wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > 4) If you insist on having /etc/mtab the same file in all namespaces,
> > you obviously will have its contents not matching at least some
> > of them.  Either have it separate in each namespace where you want
> > to see it, or simply use /proc/self/mounts instead.
> 
> So /proc/mounts should be a symlink to /proc/self/mounts?

; ls -l /proc/mounts
lrwxrwxrwx  1 root root 11 Oct  4 20:13 /proc/mounts -> self/mounts
;

like that, perhaps?  IOW, it's been done that way for almost 4 years
already...
