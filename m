Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313076AbSC0TIB>; Wed, 27 Mar 2002 14:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313071AbSC0THv>; Wed, 27 Mar 2002 14:07:51 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:21258 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S313074AbSC0THj>; Wed, 27 Mar 2002 14:07:39 -0500
Date: Wed, 27 Mar 2002 20:07:31 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] speed up ext3 synchronous mounts
Message-ID: <20020327190731.GA12677@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9E4A18.7DDC68AB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Andrew Morton wrote:

> Again, we don't need to sync indirects as we dirty them because
> we run a commit if IS_SYNC(inode) prior to returning to the
> caller of write(2).

Will this help synchronous NFS writes, at least a little? I have slow
write performance on "sync" NFSv3 exports (ext3 underneath, you guessed
it), kernel 2.4.19-pre3-ac4 (not really surprising, sync is slow ;-). Is
it worth a try?
