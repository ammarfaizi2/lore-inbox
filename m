Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWDQOph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWDQOph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWDQOph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:45:37 -0400
Received: from tim.rpsys.net ([194.106.48.114]:7401 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751034AbWDQOpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:45:36 -0400
Subject: Re: [PATCH] fbdev: Fix return error of fb_write
From: Richard Purdie <rpurdie@rpsys.net>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <444086CB.2000700@gmail.com>
References: <1145009768.6179.7.camel@localhost.localdomain>
	 <44404401.3030702@gmail.com> <20060414213105.09f0dd8d.akpm@osdl.org>
	 <444086CB.2000700@gmail.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 15:45:10 +0100
Message-Id: <1145285110.6199.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-15 at 13:38 +0800, Antonino A. Daplas wrote:
> Fix return code of fb_write():
> 
> If at least 1 byte was transferred to the device, return number of bytes,
> otherwise:
> 
>     - return -EFBIG - if file offset is past the maximum allowable offset or
>       size is greater than framebuffer length
>     - return -ENOSPC - if size is greater than framebuffer length - offset
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>

I can confirm this fixes the problem I reported, thanks!

Richard

