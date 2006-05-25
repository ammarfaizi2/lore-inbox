Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWEYPso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWEYPso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWEYPso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:48:44 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:34692 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751023AbWEYPsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:48:43 -0400
Message-ID: <348572120.26227@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 23:48:46 +0800
To: linux-kernel@vger.kernel.org
Cc: Limin Wang <lance.lmwang@gmail.com>
Subject: Re: [PATCH 28/33] readahead: loop case
Message-ID: <20060525154846.GA6907@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Limin Wang <lance.lmwang@gmail.com>
References: <20060524111246.420010595@localhost.localdomain> <20060524111911.032100160@localhost.localdomain> <20060524140135.GA19663@laptop.exavio.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524140135.GA19663@laptop.exavio.cn>
User-Agent: Mutt/1.5.11+cvs20060126
From: wfg <wfg@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 10:01:35PM +0800, Limin Wang wrote:
> 
> If the loopback files is bigger than the memory size, it may cause miss again and
> may better to turn on the read ahead?
> 

The readahead is always on, it's only disabling lookahead :-)

> > Disable look-ahead for loop file.
> > 
> > Loopback files normally contain filesystems, in which case there are already
> > proper look-aheads in the upper layer, more look-aheads on the loopback file
> > only ruins the read-ahead hit rate.
