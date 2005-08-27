Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVH0ELc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVH0ELc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 00:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVH0ELc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 00:11:32 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:36308 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1030298AbVH0ELb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 00:11:31 -0400
X-ORBL: [67.124.117.85]
Date: Fri, 26 Aug 2005 21:11:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kent Robotti <dwilson24@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050827041125.GA19212@taniwha.stupidest.org>
References: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com> <20050826190647.GA12296@taniwha.stupidest.org> <20050826200851.GA851@Linux.nyc.rr.com> <20050826202226.GA13807@taniwha.stupidest.org> <20050826211231.GA957@Linux.nyc.rr.com> <20050827004045.GA17686@taniwha.stupidest.org> <20050827032127.GA4736@Linux.nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050827032127.GA4736@Linux.nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 03:21:27AM +0000, Kent Robotti wrote:

> The purpose of the patch is to overmount ramfs/rootfs with tmpfs before
> the compressed cpio archive is unpacked and /init is run.

yes and no

there are people who want the overmount even without cpio
decompression

> But, it's only needed because the current initramfs implementation
> doesn't offer tmpfs as an option.

tmpfs isn't initialized early enough; i've hacked around this but a
cleaner solution is needed

> /init could just be a symbolic link to /sbin/init, or it could be
> some other executable (shell script etc.), but there would be no
> need to pivot or move root.

pivot is evil, it probably should be depricated
