Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUDAUqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUDAUqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:46:01 -0500
Received: from ns.suse.de ([195.135.220.2]:33433 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262923AbUDAUqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:46:00 -0500
Date: Thu, 1 Apr 2004 22:46:04 +0200
From: Andi Kleen <ak@suse.de>
To: Daniel Jacobowitz <dan@debian.org>
Cc: weigand@i1.informatik.uni-erlangen.de, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-Id: <20040401224604.5c3b45ff.ak@suse.de>
In-Reply-To: <20040401203923.GA32177@nevyn.them.org>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de>
	<20040401203923.GA32177@nevyn.them.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004 15:39:23 -0500
Daniel Jacobowitz <dan@debian.org> wrote:
> > 
> 
> (I haven't tested anything but...) why should this fix it?  Ulrich's
> problem happens when the .o file is flushed from the cache, and then
> stat'd; it now appears to be older than the .c file.  With a change to
> round up instead, if the .c file is flushed from the cache before the
> .o, the .c will still suddenly appear to be newer than the .o.

That is what he wants I think. It's logically just like taking a bit longer. 

-Andi
