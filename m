Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932304AbWFDXEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWFDXEs (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWFDXEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:04:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:11965 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932304AbWFDXEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:04:47 -0400
Message-ID: <448366FB.1070407@zytor.com>
Date: Sun, 04 Jun 2006 16:04:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
References: <20060604135011.decdc7c9.akpm@osdl.org>
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> git-klibc.patch
> 
>  Similar.  This all appears to work sufficiently well for a 2.6.18 merge. 
>  But it's been so long since klibc was a hot topic that I've forgotten who
>  wanted it, and what for.
> 
>  Can whoever has an interest in this work please pipe up and let's get our
>  direction sorted out quickly.
> 

klibc (early userspace) in its current form is fundamentally a cleanup. 
  What it does is unload code from the kernel which has no fundamental 
reason to be kernel code (written during kernel rules, with all the 
problems it entails.)  The initial code to have removed is the 
root-mounting code, with all the various ugly mutations of that (ramdisk 
loading, NFS root, initrd...)

The original idea was due Al Viro; obviously, the implementation is 
mostly mine.

It is of course my hope that this will be used for more than just plain 
initialization code, but that in itself is a significant step, and one 
has to start somewhere.

Part of the reason it has taken as long is it has is just to try to make 
it as drop-in as at all possible.

	-hpa
