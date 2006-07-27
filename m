Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWG0OTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWG0OTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWG0OTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:19:17 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:40795 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751204AbWG0OTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:19:16 -0400
Message-ID: <44C8CB5F.5040705@tls.msk.ru>
Date: Thu, 27 Jul 2006 18:19:11 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [WARNING -mm] 2.6.18-rc2-mm1 build kills /dev/null!?
References: <20060727101128.GA31920@rhlx01.fht-esslingen.de>
In-Reply-To: <20060727101128.GA31920@rhlx01.fht-esslingen.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hello all,
> 
> for some reason a 2.6.18-rc2-mm1 build seems to kill my /dev/null device!
> 
> A simple
> # make bzImage modules modules_install
> managed to reduce my
> 
> crw-rw-rw-    1 root     root       1,   3 27. Jul 12:04 null
> 
> into the charred remains equivalent of
> 
> -rw-r--r--    1 root     root            0 27. Jul 12:02 null

Don't build as root.

While something's broke in kernel build scripts and probably
should be fixed, it's not a reason for anyone to get their
whole filesystem rm -rf'ed.

/mjt
