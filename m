Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313413AbSDGVet>; Sun, 7 Apr 2002 17:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSDGVes>; Sun, 7 Apr 2002 17:34:48 -0400
Received: from ns.suse.de ([213.95.15.193]:57873 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313413AbSDGVer>;
	Sun, 7 Apr 2002 17:34:47 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
In-Reply-To: <20020407193245.GA21570@compsoc.man.ac.uk.suse.lists.linux.kernel> <E16uIoN-0006b3-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Apr 2002 23:34:46 +0200
Message-ID: <p73it73p4zt.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > The system call tracking is only used to associate a particular EIP with
> > a particular offset in some binary image. There's no other efficient
> > method to capture the mmap() calls for these images, for everything
> > running. ptrace() is only really useful for a small number of processes,
> > and is slow. Offline post-analysis isn't possible. There is no
> > API for getting access to this information.
> 
> Ok, so you have a real reason for dealing with it

pice (another kernel debugger) needs it also, it's not only oprofile. 

I think it is a bad idea to remove it. It just means that these programs
will access it via System.map instead of an exported symbol. It doesn't change
anything, just makes life harder for some people. 

> Lets see if we can sort out AFS and the like then come back to that one. I
> think you may have a valid point. If 2.5 has EXPORT_SYMBOL_INTERNAL it 
> gets a lot easier.

That doesn't help the oprofile users who want to use it in 2.4 now. 

-Andi
