Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbREMKsq>; Sun, 13 May 2001 06:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbREMKsg>; Sun, 13 May 2001 06:48:36 -0400
Received: from ns.suse.de ([213.95.15.193]:44554 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261394AbREMKsb>;
	Sun, 13 May 2001 06:48:31 -0400
Date: Sun, 13 May 2001 12:48:05 +0200
From: Andi Kleen <ak@suse.de>
To: Philip Wang <PXWang@stanford.edu>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@cs.Stanford.EDU>
Subject: Re: [PATCH] vmalloc NULL Check Bug Fix
Message-ID: <20010513124805.A10250@gruyere.muc.suse.de>
In-Reply-To: <5.0.2.1.2.20010513005434.00a84d00@pxwang.pobox.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010513005434.00a84d00@pxwang.pobox.stanford.edu>; from PXWang@stanford.edu on Sun, May 13, 2001 at 01:07:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 01:07:03AM -0700, Philip Wang wrote:
> Hello!
> 
> I'm Philip, from Professor Dawson Engler's Meta-Compilation Group at 
> Stanford University.
> 
> This simple and obvious bug fix makes sure that vmalloc() does not return 
> NULL.  My addition of returning -1 is consistent with how the rest of the 
> code deals with allocation failures.

The error handling paths in ftl.c still look awfully incomplete -- they don't
free any resources previously allocated when a memory allocation failure 
happens.

-Andi

