Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280831AbRKLQO2>; Mon, 12 Nov 2001 11:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280832AbRKLQOT>; Mon, 12 Nov 2001 11:14:19 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:34361 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280831AbRKLQOL>; Mon, 12 Nov 2001 11:14:11 -0500
Date: Mon, 12 Nov 2001 18:13:51 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Patrick Caulfield <caulfield@sistina.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [PATCH] lvm in 2.4.15.pre3
Message-ID: <20011112181351.D1504@niksula.cs.hut.fi>
In-Reply-To: <20011112130101.A11020@tykepenguin.com> <E163GzN-0005po-00@the-village.bc.nu> <20011112162337.J26218@niksula.cs.hut.fi> <20011112143432.B580@tykepenguin.com> <20011112175101.B1504@niksula.cs.hut.fi> <20011112160412.C580@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011112160412.C580@tykepenguin.com>; from caulfield@sistina.com on Mon, Nov 12, 2001 at 04:04:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 04:04:12PM +0000, you [Patrick Caulfield] claimed:
> On Mon, Nov 12, 2001 at 05:51:01PM +0200, Ville Herva wrote:
> > On Mon, Nov 12, 2001 at 02:34:32PM +0000, you [Patrick Caulfield] claimed:
> > > On Mon, Nov 12, 2001 at 04:23:37PM +0200, Ville Herva wrote:
> > > > On Mon, Nov 12, 2001 at 01:19:01PM +0000, you [Alan Cox] claimed:
> > > > > > Please apply the following patch to LVM in 2.4.13pre3.
> > > > > > 
> > > > > > It looks like the LVM patch that came from Alan calls alloc/free_kiovec_sz
> > > ()
> > > > > > functions which only exist in his tree.
> > > > > 
> > > > > Just sent Linus the same thing 8)
> > > > 
> > > > Sorry if this is a FAQ, but I see the LVM in .15pre3 is 0.9.1beta2. Are there
> > > > plans to merge something newer like 1.0.1pre4? 
> > > 
> > > I think you've misread the patch:
> > > 
> > > lvm.h:#define LVM_RELEASE_NAME "1.0.1-rc4(ish)"
> > 
> > Ummh, maybe I'm doing something wrong, but my copy of 2.4.15pre3 says
> > 
> > less -N include/linux/lvm.h:
> >     67  #ifndef _LVM_H_INCLUDE
> >     68  #define _LVM_H_INCLUDE
> >     69
> >     70  #define _LVM_KERNEL_H_VERSION   "LVM 0.9.1_beta2 (18/01/2001)"
> >     71
> >     72  #include <linux/config.h>
> >     73  #include <linux/version.h>
> > 
> 
> > ./drivers/md/lvm-internal.h:#define _LVM_INTERNAL_H_VERSION "LVM"LVM_RELEASE_NAME" ("LVM_RELEASE_DATE")"
> > 
> > Does it generate the LVM_RELEASE_NAME dynamically on first build?
> 
> No it doesn't. 
> 
> I can only assume your patch hasn't applied correctly - look at the patch
> itself:
> 
> @@ -67,9 +73,11 @@
>  #ifndef _LVM_H_INCLUDE
>  #define _LVM_H_INCLUDE
>  
> -#define        _LVM_KERNEL_H_VERSION   "LVM 0.9.1_beta2 (18/01/2001)"
> +#define LVM_RELEASE_NAME "1.0.1-rc4(ish)"
> +#define LVM_RELEASE_DATE "03/10/2001"
> +
> +#define _LVM_KERNEL_H_VERSION   "LVM "LVM_RELEASE_NAME" ("LVM_RELEASE_DATE")"
>  
> -#include <linux/config.h>
>  #include <linux/version.h>

It must be that (I was using non-gnu patch(1)).

Sorry for the noise.

BTW: When was 1.0.1-rc4 merged to -ac / mainline? I missed that...


-- v --

v@iki.fi
