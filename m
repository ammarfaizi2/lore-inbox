Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVBVSqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVBVSqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVBVSqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:46:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:61570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261278AbVBVSp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:45:58 -0500
Date: Tue, 22 Feb 2005 10:45:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: mingo@elte.hu, raybry@sgi.com, mort@wildopensource.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050222104535.0b3a3c65.akpm@osdl.org>
In-Reply-To: <20050222032633.5cb38abb.pj@sgi.com>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
	<20050221134220.2f5911c9.akpm@osdl.org>
	<421A607B.4050606@sgi.com>
	<20050221144108.40eba4d9.akpm@osdl.org>
	<20050222075304.GA778@elte.hu>
	<20050222032633.5cb38abb.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  As Martin wrote, when he submitted this patch:
>  > The motivation for this patch is for setting up High Performance
>  > Computing jobs, where initial memory placement is very important to
>  > overall performance.
> 
>  Any left over cache is wrong, for this situation.

So...  Cannot the applicaiton remove all its pagecache with posix_fadvise()
prior to exitting?
