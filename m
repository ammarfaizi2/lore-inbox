Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSA3Ez1>; Tue, 29 Jan 2002 23:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSA3EzP>; Tue, 29 Jan 2002 23:55:15 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:22283 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288512AbSA3EzA>;
	Tue, 29 Jan 2002 23:55:00 -0500
Date: Wed, 30 Jan 2002 15:50:40 +1100
From: Anton Blanchard <anton@samba.org>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
Message-ID: <20020130045040.GA18567@krispykreme>
In-Reply-To: <1012348838.817.50.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012348838.817.50.camel@phantasy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch pushes the BKL out of llseek() and into the individual llseek
> methods.  For generic_file_llseek, I replaced it with the inode
> semaphore.  The lock contention is noticeable even on 2-way systems. 
> Since we simply push the BKL further down the call chain (its the llseek
> method's responsibilities now) we aren't doing anything hackish or
> unsafe.

A great idea, I wonder why someone didnt think of it before?

http://banyan.dlut.edu.cn/news/112801/0186.html

Wow someone did! And the patch basically matches yours including whitespace.

Robert _please_ attribute your sources more carefully. 

Anton
