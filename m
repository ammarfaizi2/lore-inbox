Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVCUKd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVCUKd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVCUKd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:33:28 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:57770 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261567AbVCUKdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:33:24 -0500
Date: Mon, 21 Mar 2005 11:15:32 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Why is NFS write so slow?
Message-ID: <20050321101532.GA14298@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4ae3c1405032100293ff52077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c1405032100293ff52077@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Xin Zhao wrote:

> I am trying to develop a new filesystem based on NFS, which runs in a
> very fast network environment. I used the source code of NFS2, but
> noticed that NFS write is very slow. Even if I changed wsize to 8192,
> it still can only reach 1MB/s. I don't know why. Because the network
> is extremely fast (over 100MB/s), I don't think network is the only
> reason. Any other reason?
> 
> Is the NFS write synchronous? Does that means the NFS server will not
> return before the data is flushed to disk?

Yes, that is the case here. You can use export or mount options to make
NFS asynchronous.

Plus, NFS3 has write clustering which may be worth a try depending on
your workload.

-- 
Matthias Andree
