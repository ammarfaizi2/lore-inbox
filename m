Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264755AbUEETrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264755AbUEETrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 15:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEETre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 15:47:34 -0400
Received: from server2.netdiscount.de ([217.13.198.2]:14720 "EHLO
	server2.netdiscount.de") by vger.kernel.org with ESMTP
	id S264758AbUEETr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 15:47:26 -0400
Date: Wed, 5 May 2004 21:47:13 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: virt_to_page() with ioremap_nocache -> Ooops
Message-ID: <20040505194713.GA24904@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have implemented mmap with (nopage), the mmaping consists of normal
memory from __get_free_pages (set to RESERVED) and some registers/memory
that are on a PCI card (bar0), i mapped it with ioremap_nocache to to be
able to read and write it in kernelspace.

I tried to use virt_to_page(address_from_ioremap_nocache + some_offset)
and gave this back from the (nopage) function, but this leads to an
Oops. (with the other memory it works)

Where is here my error?


Regards
Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
