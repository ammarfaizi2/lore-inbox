Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSIBLNc>; Mon, 2 Sep 2002 07:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSIBLNc>; Mon, 2 Sep 2002 07:13:32 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:17415 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S318274AbSIBLNb>; Mon, 2 Sep 2002 07:13:31 -0400
Date: Mon, 2 Sep 2002 12:54:33 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Molbo <molbo@inbox.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how get dentry cache to swap
Message-ID: <20020902125433.H781@nightmaster.csn.tu-chemnitz.de>
References: <882173015.20020902130938@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <882173015.20020902130938@inbox.ru>; from molbo@inbox.ru on Mon, Sep 02, 2002 at 01:09:38PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 01:09:38PM +0400, Molbo wrote:
> if I try to create on tmpfs 100k nodes, this kills all my free 25Mb
> Ram.
> question is can be dentry cache made swap cachable

Yes, by providing a real inode-like entity in swap.

This is overkill. Use a real file system for your use case. 
I think tmpfs is not suited for your need.

Tmpfs is for machines where hitting swap is unlikely but
possible. So creating all temporary FS structures in memory only
makes sense. 

For your use case it doesn't make sense and you should use a
normal file system that writes out all its state, if memory gets
thight (or the state is getting too old).

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
