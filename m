Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315808AbSEWBzp>; Wed, 22 May 2002 21:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315814AbSEWBzo>; Wed, 22 May 2002 21:55:44 -0400
Received: from rj.SGI.COM ([192.82.208.96]:53403 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315808AbSEWBzn>;
	Wed, 22 May 2002 21:55:43 -0400
Date: Thu, 23 May 2002 11:55:09 +1000
From: Nathan Scott <nathans@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Kara <jack@suse.cz.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020523115509.W180298@wobbly.melbourne.sgi.com>
In-Reply-To: <20020523105947.A186660@wobbly.melbourne.sgi.com> <E17AhqN-0003Kj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Alan,

On Thu, May 23, 2002 at 02:56:43AM +0100, Alan Cox wrote:
> > On Thu, May 23, 2002 at 09:30:10AM +1000, Nathan Scott wrote:
> > > ... but that should just about do the trick I think.
> > 
> > How does the patch below look Jan?
> 
> Doesn't let me select both ?
> 
> > +if [ "$CONFIG_QUOTA" = "y" ]; then
> > +   define_bool CONFIG_QUOTACTL y
> > +   if [ "$CONFIG_QIFACE_COMPAT" = "y" ]; then
> > +       choice '    Compatible quota interfaces' \
> > +		"Original	CONFIG_QIFACE_V1 \
> > +		 VFSv0		CONFIG_QIFACE_V2" Original
> > +   fi
> >  fi
> 

I think that was Jan's intention (the patch I sent doesn't change
that aspect of things)...

-if [ "$CONFIG_QUOTA" = "y" -a "$CONFIG_QIFACE_COMPAT" = "y" ]; then
-   choice '    Compatible quota interfaces' \
-       "Original       CONFIG_QIFACE_V1 \
-        VFSv0          CONFIG_QIFACE_V2" Original


So all I've really added is the line:
+   define_bool CONFIG_QUOTACTL y


wrt having both, iirc there was overlap between the original ABI
and Jan's new 32bit one - I suspect thats why both together is
disallowed, but Jan will be able to give the definitive answers
there.

cheers.

-- 
Nathan
