Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292918AbSBVQAT>; Fri, 22 Feb 2002 11:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292919AbSBVQAJ>; Fri, 22 Feb 2002 11:00:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25619 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292918AbSBVP7w>;
	Fri, 22 Feb 2002 10:59:52 -0500
Date: Fri, 22 Feb 2002 16:52:05 +0100
From: Jens Axboe <axboe@suse.de>
To: "Paulo Andre'" <l16083@alunos.uevora.pt>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sym53c416 driver breakage
Message-ID: <20020222155205.GA2782@suse.de>
In-Reply-To: <20020222160250.D241@bleach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020222160250.D241@bleach>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22 2002, Paulo Andre' wrote:
> Hi,
> 
> The following patch fixes a small bug which prevented the Sym53c416 
> driver from compiling. I don't know to which degree this is the right 
> fix, since the 'address' field from struct scatterlist just seemed to 
> magically disappear. If this was intended, meaning my fix isn't 
> correct, I'd like to know about it.

This is very wrong, we removed ->address for a reason (unify handling of
lo+hi memory suppot). So it may fix you compile, but that's all it will
fix. IOW, it won't work.

-- 
Jens Axboe

