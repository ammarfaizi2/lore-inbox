Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVCHJJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVCHJJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVCHJJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:09:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36364 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261894AbVCHJJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:09:49 -0500
Date: Tue, 8 Mar 2005 09:09:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Hugh Dickins <hugh@veritas.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/swap_state.c: unexport swapper_space
Message-ID: <20050308090943.A26847@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hugh Dickins <hugh@veritas.com>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050306144758.GJ5070@stusta.de> <Pine.LNX.4.61.0503061515200.19898@goblin.wat.veritas.com> <20050306224912.GE5827@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050306224912.GE5827@infradead.org>; from hch@infradead.org on Sun, Mar 06, 2005 at 10:49:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 10:49:12PM +0000, Christoph Hellwig wrote:
> I disagree.  swapper_state is far too much of an internal detail to be
> exported.  I argued that way when page_mapping was changed to use it and
> that's why the architectures moved their helpers out of line.
> Looks like the exported unfortunately got added anyway although we settled
> that discussion.

Well, since ARM's usage of page_mapping() is out of line (which is
where it'll now stay) I think Christoph is correct.  Maybe this is
something which should be aired on linux-arch for the other arch
maintainers?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
