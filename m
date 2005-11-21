Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVKUQMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVKUQMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVKUQMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:12:54 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:33671 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932356AbVKUQMx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:12:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pIYOvna7mvjkBndoYguh6IU//VBMA2wuevebFKuI5HjCnwOIebYj07287FzAlfGVvOid00M5vfaZ/TKaVoD0orZrEAo4WLO07KiHSl1BjR2rs2lUq60ywNDwPDek6IcA6nTIIhiubq5RXsUgoPg+lhVjtciNt1TvnVHYzV/FvgE=
Message-ID: <afcef88a0511210812u2bd10c14n23515a891e121a2e@mail.gmail.com>
Date: Mon, 21 Nov 2005 10:12:52 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <afcef88a0511210810m751e8d35p603915edf96a67c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041740.GD15747@sshock.rn.byu.edu>
	 <84144f020511190247n5cf17800lb4ff019aa406470@mail.gmail.com>
	 <afcef88a0511210810m751e8d35p603915edf96a67c6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Michael Thompson <michael.craig.thompson@gmail.com> wrote:
> On 11/19/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > > +       return register_filesystem(&ecryptfs_fs_type);
> >
> > register_filesystem() can fail in which case youre leaking all the
> > slab caches here.
>
> I wasn't aware it _could_ fail, thanks for that.

Well, let me rephrase: I never bothered to check. Its obvious it can
fail, I'm just embarresed that I never bothered to find out... again,
thanks for catching that.

>
> >
> >                                       Pekka
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>
> --
> Michael C. Thompson <mcthomps@us.ibm.com>
> Software-Engineer, IBM LTC Security
>


--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
