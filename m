Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbTFYRaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbTFYRaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:30:18 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:46599 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264696AbTFYRaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:30:16 -0400
Date: Wed, 25 Jun 2003 18:44:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lou Langholtz <ldl@aros.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl UI
Message-ID: <20030625184423.A29537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lou Langholtz <ldl@aros.net>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net> <20030625165513.A20328@infradead.org> <3EF9DE23.2080806@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EF9DE23.2080806@aros.net>; from ldl@aros.net on Wed, Jun 25, 2003 at 11:38:43AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 11:38:43AM -0600, Lou Langholtz wrote:
> Yes. To be fair though, the binary (and the driver too) was broken on 
> linux 2.5 kernels long before I even proposed any changes to the nbd 
> driver. I'm trying to fix that.

Hey, I didn't say changing the interface is wrong.  But if possible
do it in a way that the new userspace can still support the old kernel
driver.

> NBD_SET_SOCK. That'd tell nbd-tool that the nbd driver thinks something 
> about the ioctl was invalid but not what. I wanted to return EDEPRECATED 
> instead but I haven't found that errno yet. I could overload an errno 
> but that seems ugly too. Or the driver could have a NBD_GET_VERSION 
> ioctl. Is there precedence for that? I haven't come accross it yet.

That's one choice.  At least md and device mapper do that.

