Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTDQODb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTDQODb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:03:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34246
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261440AbTDQODa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:03:30 -0400
Subject: Re: [BK+PATCH] remove __constant_memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3E9DFC11.50800@pobox.com>
References: <3E9DFC11.50800@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050585430.31390.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:17:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 01:57, Jeff Garzik wrote:
> The patch below is the conservative, obvious patch.  It only kicks in 
> when __builtin_constant_p() is true, and it only applies to the i386 
> arch.  

You are assuming the compiler is smart about stuff - it doesnt know
SSE/MMX for page copies etc. For small copies it should alays win, but
isn't it best if so to use __builtin_memcpy without our existing
macros not just trust the compiler ?

