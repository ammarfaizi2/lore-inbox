Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWEDO0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWEDO0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWEDO0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:26:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:42308 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751453AbWEDO0o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:26:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oTnWkm2ZZVeG1FauuyRNbAjGxUuSH07HxWQFR0a16XgjQz6lAS5x62MpoM1GKqgQyPwMJe5OSQwN4wBjCDyB7LThL32M/r7ceIVziW1NhBIg2zETZKC8Nhh8J2CPd8GWI7OyDAwUMyUa7tyMjo3bkfXmHkMtRwkSEFDt8SS664M=
Message-ID: <84144f020605040726p2279aabag325c6c74cbb16ea6@mail.gmail.com>
Date: Thu, 4 May 2006 17:26:43 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Michael Thompson" <michael.craig.thompson@gmail.com>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
Cc: "Pavel Machek" <pavel@suse.cz>,
       "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <afcef88a0605040702q199a2be2tdd8a291eacf7035@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033829.GE28613@hellewell.homeip.net>
	 <20060504095552.GC5844@ucw.cz>
	 <afcef88a0605040702q199a2be2tdd8a291eacf7035@mail.gmail.com>
X-Google-Sender-Auth: 0328d3ebb79d8d66
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/4/06, Pavel Machek <pavel@suse.cz> wrote:
> > > +static int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
> > > +{
> > > +     int rc = 0;
> > > +
> > > +     ecryptfs_printk(KERN_DEBUG, "Enter\n");
> > > +     rc = vfs_statfs(ECRYPTFS_SUPERBLOCK_TO_LOWER(sb), buf);
> > > +     ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
> > > +     return rc;
> > > +}
> >
> > This is ugly. Could you remove the debugging, or at least use dprintk?

On 5/4/06, Michael Thompson <michael.craig.thompson@gmail.com> wrote:
> How would dprintk differ from the current approach with ecryptfs_printk?

Not much, so please just kill the function tracing stuffs. Thanks.

                                           Pekka
