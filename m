Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWEDOCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWEDOCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWEDOCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:02:51 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:61162 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751157AbWEDOCt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:02:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sR2avBtFTKZKND9zoVsCi65Vpe2hU3Zs3bbJnFEAqc0ei/FqebmlXoLYNzEwxH8UUuknvAzq/is1H1OOX5DP2A3K9bBKOz6RLjTquvmrxhGZk1cxBuf695ohbXtkra+ZKSbH+qRtbOTCjK3acIa+58rEfNi1ojqstJzv0xDA1TE=
Message-ID: <afcef88a0605040702q199a2be2tdd8a291eacf7035@mail.gmail.com>
Date: Thu, 4 May 2006 09:02:49 -0500
From: "Michael Thompson" <michael.craig.thompson@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
Cc: "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <20060504095552.GC5844@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033829.GE28613@hellewell.homeip.net>
	 <20060504095552.GC5844@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Pavel Machek <pavel@suse.cz> wrote:
> HI!
>
> > +/**
> > + * Get the filesystem statistics. Currently, we let this pass right through
> > + * to the lower filesystem and take no action ourselves.
> > + */
> > +static int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
> > +{
> > +     int rc = 0;
> > +
> > +     ecryptfs_printk(KERN_DEBUG, "Enter\n");
> > +     rc = vfs_statfs(ECRYPTFS_SUPERBLOCK_TO_LOWER(sb), buf);
> > +     ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
> > +     return rc;
> > +}
>
> This is ugly. Could you remove the debugging, or at least use dprintk?

How would dprintk differ from the current approach with ecryptfs_printk?

--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
