Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWHKACY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWHKACY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHKACY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:02:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:47786 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932337AbWHKACY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:02:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f0I2b48ZQfeF6cP9YggFpCkBGB0BDeIRnAENx0Hao6kd9T1wiXye9Ty3DJgMuCK64gYlXkhdj6GG22rJDIcECtV50InSkHj0KHsHKHUdfQWwAGjAh2klqzNVeN0RXDqda8YamRzquPQrZJ2ODPetpqY8NYW00MrynwvpY22QZj0=
Message-ID: <9a8748490608101702k2c25200cr4245b9a1427e4901@mail.gmail.com>
Date: Fri, 11 Aug 2006 02:02:22 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: XFS warning in 2.6.18-rc4
Cc: "Meelis Roos" <mroos@linux.ee>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060811095210.I2596458@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee>
	 <20060810085616.C2581413@wobbly.melbourne.sgi.com>
	 <9a8748490608101647l4f51e761o6dc1f703c9d012b2@mail.gmail.com>
	 <20060811095210.I2596458@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/06, Nathan Scott <nathans@sgi.com> wrote:
> On Fri, Aug 11, 2006 at 01:47:43AM +0200, Jesper Juhl wrote:
> > On 10/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > On Wed, Aug 09, 2006 at 11:04:53PM +0300, Meelis Roos wrote:
> > > > fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
> > > > fs/xfs/xfs_bmap.c:2662: warning: 'rtx' is used uninitialized in this function
> > >
> > > You have a particularly dense compiler, unfortunately.  This code
> > > has always been this way, its just a false cc warning that can be
> > > safely ignored until you upgrade to a fixed compiler (unless I'm
> > > missing something - please enlighten me if so).  It does seem to
> > > be the case that there is no way 'rtx' will be used uninitialised
> > > when xfs_rtpick_extent() doesn't fail... no?
> > >
> > Ok, I may be reading something wrong here, but I think the warning is
> > actually not correct.
>
> Thats how I read it too.  By "dense" I meant "buggy".
>
> > Or am I missing something ?
>
> Nope, thats my understanding too.  The compiler is wrong in this case.
> The only open issue I guess is whether its worh rearranging the code
> to stop people reporting it as a problem...  *shrug*.
>
I don't see how it would hurt ;)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
