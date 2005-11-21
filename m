Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVKUQPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVKUQPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVKUQPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:15:55 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:36767 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932362AbVKUQPy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:15:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DdagaO9PcWBrowI2O9MtxseL68OCmmuwCNmxfWrLxyvwbhe/apacN5rOezOBl0KhHYrjd6zqtYcte3Ozy9eV+gZhdc8AFy/LqODS7QE0Gikl0Q5vYGJTTdxcOCiyIZwpndZGQmMbsxLisZBFNre5mYhBt6LYDbR3Yi+YIHXlyMo=
Message-ID: <afcef88a0511210815o160f4a8k772d2cf3954c6602@mail.gmail.com>
Date: Mon, 21 Nov 2005 10:15:53 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 6/12: eCryptfs] Superblock operations
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <afcef88a0511210813i5a5f4382k1b5e876fbbb9a931@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041910.GF15747@sshock.rn.byu.edu>
	 <84144f020511190250x2efdbfb4vf33245b3f7216fe5@mail.gmail.com>
	 <afcef88a0511210757y4fdb8c57w221b0fc9e7ee3ee4@mail.gmail.com>
	 <1132588916.8487.3.camel@localhost>
	 <afcef88a0511210813i5a5f4382k1b5e876fbbb9a931@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Michael Thompson <michael.craig.thompson@gmail.com> wrote:
> On 11/21/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > Hi,
> >
> > On 11/19/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > > > > +/**
> > > > > + * This is called through iput_final().
> > > > > + * This is function will replace generic_drop_inode. The end result of which
> > > > > + * is we are skipping the check in inode->i_nlink, which we do not use.
> > > > > + */
> > > > > +static void ecryptfs_drop_inode(struct inode *inode) {
> > > > > +       generic_delete_inode(inode);
> > > > > +}
> > > >
> > > > Please drop this useless wrapper and introduce it when it actually
> > > > does something.
> >
> > On Mon, 2005-11-21 at 09:57 -0600, Michael Thompson wrote:
> > > I don't see a problem with doing that, but perhaps there is? Please
> > > elaborate if so.
> >
> > You can set ecryptfs_sops->drop_inode to generic_delete_inode directly,
> > no?
>
> Yes, I do believe I could do that and save a function call. My mind is
> wobbely today.

Very wobbley, can't even spell right. Is this an acceptable solution?
I didn't even bother to ask that ;)

>
> >
> >                         Pekka
> >
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
