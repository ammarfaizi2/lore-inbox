Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273079AbTG3R0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273081AbTG3R0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:26:18 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:51957 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S273079AbTG3R0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:26:16 -0400
Subject: Re: TSCs are a no-no on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E19huHB-0000Or-00@chiark.greenend.org.uk>
References: <20030730135623.GA1873@lug-owl.de>
	 <E19huHB-0000Or-00@chiark.greenend.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059585565.10452.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 18:19:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 17:58, Matthew Garrett wrote:
> g++ >=3.2 use 486-specific instructions in order to do atomic operations
> in C++ code. 3.3 includes a 386 version of the same code, but it's not
> possible to use a mixture of the two (ie, code compiled with a "486" g++
> will not work on the "386" version), and so to keep ABI compatibility
> with the other distributions it's necessary to break 386. The "obvious"
> solution (dragging this back on topic) is a kernel patch to emulate 486
> instructions on a 386.

You don't need to mash the kernel up for this - you can write yourself a
SIGILL handler to do the work - take a look at things like the pure
software MMX preloader someone wrote.


