Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRKNG3T>; Wed, 14 Nov 2001 01:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280186AbRKNG3J>; Wed, 14 Nov 2001 01:29:09 -0500
Received: from ns.suse.de ([213.95.15.193]:11782 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280171AbRKNG2y>;
	Wed, 14 Nov 2001 01:28:54 -0500
Date: Wed, 14 Nov 2001 07:28:52 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: vonbrand@inf.utfsm.cl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011114072852.A16556@suse.de>
In-Reply-To: <torvalds@transmeta.com> <200111131410.fADEA9L8023291@pincoya.inf.utfsm.cl> <20011113162102.A2305@suse.de> <20011113.205729.71087461.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011113.205729.71087461.davem@redhat.com>; from davem@redhat.com on Tue, Nov 13, 2001 at 08:57:29PM -0800
Organization: SuSE GmbH, Nuernberg, Germany
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, David S. Miller wrote:

> 
> This first patch is wrong.  lv_block_exception needs translating
> because the types are of a different size on sparc32 than on sparc64.
> 
> Specifically the first member of lv_block_exception_t is
> 'struct list_head', which are two pointers, which is 8 bytes
> on sparc32 and 16 bytes on sparc64.
> 
> Please do not apply these patches.

If the first one should be wrong, why not apply the second one ?
Or I'm missing something ?
To the first patch: Without it you will always get a kernel oops
in this part of ioctl32.c

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE GmbH            Deutschherrenstr. 15-19       D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B
