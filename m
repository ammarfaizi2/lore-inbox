Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263306AbVCJX1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbVCJX1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbVCJX1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:27:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:1665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263306AbVCJXXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:23:24 -0500
Date: Thu, 10 Mar 2005 15:21:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version
In-Reply-To: <20050310225340.GD3205@stusta.de>
Message-ID: <Pine.LNX.4.58.0503101516190.2530@ppc970.osdl.org>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
 <20050310225340.GD3205@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Mar 2005, Adrian Bunk wrote:
> 
> This patch is still wrong.

Can't we just fix it by havign an alias for both names? It seems stupid to 
jump through hoops and worry about compiler versions, when afaik we could 
just do something like

	extern xxxx(...) __attribute__((alias("yyyy")));

instead. Exact details left to the reader who knows more about all the 
magic gcc/linker things..

		Linus
