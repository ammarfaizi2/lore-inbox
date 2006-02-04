Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946319AbWBDGad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946319AbWBDGad (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 01:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946318AbWBDGad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 01:30:33 -0500
Received: from mx1.mail.ru ([194.67.23.121]:25671 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1946316AbWBDGac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 01:30:32 -0500
Date: Sat, 4 Feb 2006 09:18:48 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ufs: fill i_size at directory creation
Message-ID: <20060204061848.GA11894@rain.homenetwork>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060131234634.GA13773@mipter.zuzino.mipt.ru> <20060201200410.GA11747@rain.homenetwork> <20060203174613.GA7823@mipter.zuzino.mipt.ru> <20060204011815.GA7837@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204011815.GA7837@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 04:18:15AM +0300, Alexey Dobriyan wrote:
> How about this as a first small step?
> +	inode->i_size = UFS_SB(sb)->s_uspi->s_fsize;

It looks very strange for me.

During "fill super" we set block size of device to fragment size,
so sb->s_blocksize and UFS_SB(sb)->s_uspi->s_fsize should be the 
same size on your system: 2048, hence question:
what difference between your and my patch?

-- 
/Evgeniy

