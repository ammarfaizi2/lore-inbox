Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbULMMCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbULMMCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbULMMCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:02:48 -0500
Received: from [213.146.154.40] ([213.146.154.40]:9191 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262230AbULMMCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:02:47 -0500
Date: Mon, 13 Dec 2004 12:02:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-ID: <20041213120246.GA17768@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041213020319.661b1ad9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +unlocked_ioctl.patch
> 
>  Provide a path for migrating ioctls out from under the bkl.

Please drop the struct inode parameter from the prototype of ->unlocked_ioctl.
It can easily be reached from the struct file.

