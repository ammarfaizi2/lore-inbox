Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUJKNWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUJKNWB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUJKNUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:20:15 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:52975 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S268944AbUJKNTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:19:30 -0400
Date: Mon, 11 Oct 2004 15:19:26 +0200
From: Tim Cambrant <cambrant@acc.umu.se>
To: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unable to handle kernel paging request at virtual address 0000ed9c [was Re: 2.6.9-rc4-mm1]
Message-ID: <20041011131926.GA13258@shaka.acc.umu.se>
References: <20041011032502.299dc88d.akpm@osdl.org> <416A8019.4050901@hispalinux.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <416A8019.4050901@hispalinux.es>
User-Agent: Mutt/1.4.1i
X-Operating-System: SunOS shaka.acc.umu.se 5.8 Generic_117000-05 sun4u sparc SUNW,Ultra-250 Solaris
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 02:44:09PM +0200, Ramón Rey Vicente wrote:
>  
> I get this with rc4-mm1
> 
> Unable to handle kernel paging request at virtual address 0000ed9c
> ...

This problem is left since -mm3, and is (for now) fixed by reversing
optimize-profile-path-slightly.patch. Do it like this:

cd /usr/src/linux
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
patch -R -p1 < optimize-profile-path-slightly.patch


-- 

Tim Cambrant <cambrant@acc.umu.se>
http://www.acc.umu.se/~cambrant/
