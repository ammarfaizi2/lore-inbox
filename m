Return-Path: <linux-kernel-owner+w=401wt.eu-S1945999AbWLVKBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945999AbWLVKBr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946002AbWLVKBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:01:47 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:53649 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945999AbWLVKBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:01:46 -0500
Date: Fri, 22 Dec 2006 11:01:39 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222100139.GD10273@deprecation.cyrius.com>
References: <20061220170323.GA12989@deprecation.cyrius.com> <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com> <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gordon Farquharson <gordonfarquharson@gmail.com> [2006-12-21 21:20]:
> generating these files, pkgcache.bin grows to 12582912 bytes, and when
> apt-get finishes, pkgcache.bin is 6425533 bytes and srcpkgcache.bin is
> 64254483 bytes. This time, when apt-get exited, it had only created
> pkgcache.bin which was still 12582912 bytes.

Yes, same here:

sh-3.1# ls -l /var/cache/apt/
total 5252
drwxr-xr-x 3 root root    12288 Dec 22 04:41 archives
-rw-r--r-- 1 root root 12582912 Dec 22 04:45 pkgcache.bin
-rw-r--r-- 1 root root     8554 Dec 22 04:45 srcpkgcache.bin

Gordon, does it fail for you where it normally does (installing
initramfs-tools) or much later?  For me, the installer was able to
install initramfs-tools and the kernel, but apt now hangs at "Select
and install software".
-- 
Martin Michlmayr
http://www.cyrius.com/
