Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTFYUtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTFYUtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:49:50 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:31241 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265055AbTFYUtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:49:47 -0400
Date: Wed, 25 Jun 2003 22:03:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mocm@mocm.de
Cc: Christoph Hellwig <hch@infradead.org>,
       Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625220355.A13814@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
	Michael Hunold <hunold@convergence.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030625175513.A28776@infradead.org> <16121.55366.94360.338786@sheridan.metzler> <20030625181606.A29104@infradead.org> <16121.55873.675690.542574@sheridan.metzler> <20030625182409.A29252@infradead.org> <16121.56382.444838.485646@sheridan.metzler> <20030625185036.C29537@infradead.org> <16121.58735.59911.813354@sheridan.metzler> <20030625191532.A1083@infradead.org> <16121.60747.537424.961385@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16121.60747.537424.961385@sheridan.metzler>; from mocm@metzlerbros.de on Wed, Jun 25, 2003 at 08:43:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 08:43:23PM +0200, Marcus Metzler wrote:
>  > In that case yes, you are screwed.  Your ABI just changed incompatibly.
> 
> Not if you recompile.

If you need to recompile your ABI changed.  And yes, then your absolutely
screwed.

>  > No!  <linux/*.h> is the namesapce for kernelheaders.  Currently they're
>  > still in the the user includes, too (due to legacy reasons).  The
>  > DVD API must move to a directory outside <linux/dvb>.
>  > 
> 
> Why (It's DVB by the way)? It's as close to the kernel as ls or cat
> and having two sets of the same includes is stupid. 

No, it's not.  One if for the driver you compile and one for the application.

>  > If you userland packages add headers to /usr/include/linux/ they
>  > are totally bogus.
>  > 
> 

> What packages? You are always talking about packages. There are no packages.
> There are only the kernel and my app. Nothing else. No copying of headers.

Then you need to add a package with the userland header (which, as I already
said might be exactly the same ones as those in the kernel tree).

>  > And that's wrong.  You must always compile against the kernel headers
>  > that your libc was compiled against.
>  > 
> 
> There is no one who does that, not even distributions. The includes
> needed for libc are far less prone to change than v4l or dvb. And not
> as linux specific.

Oh yes, everyone does.  Ever looked at an errata kernel from RH, SuSE
or Debian?  Yes, they never change what's /usr/include/.

> I see your point, but right now it's only academic and not practicable.

It's how Linux works.  If you don't like that play with SCO Unix or MacOS.

