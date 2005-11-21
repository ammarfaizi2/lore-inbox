Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVKUQCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVKUQCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVKUQB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:01:59 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:58500 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932306AbVKUQB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:01:58 -0500
Subject: Re: [PATCH 6/12: eCryptfs] Superblock operations
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Thompson <michael.craig.thompson@gmail.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <afcef88a0511210757y4fdb8c57w221b0fc9e7ee3ee4@mail.gmail.com>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041910.GF15747@sshock.rn.byu.edu>
	 <84144f020511190250x2efdbfb4vf33245b3f7216fe5@mail.gmail.com>
	 <afcef88a0511210757y4fdb8c57w221b0fc9e7ee3ee4@mail.gmail.com>
Date: Mon, 21 Nov 2005 18:01:56 +0200
Message-Id: <1132588916.8487.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/19/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > > +/**
> > > + * This is called through iput_final().
> > > + * This is function will replace generic_drop_inode. The end result of which
> > > + * is we are skipping the check in inode->i_nlink, which we do not use.
> > > + */
> > > +static void ecryptfs_drop_inode(struct inode *inode) {
> > > +       generic_delete_inode(inode);
> > > +}
> >
> > Please drop this useless wrapper and introduce it when it actually
> > does something.

On Mon, 2005-11-21 at 09:57 -0600, Michael Thompson wrote:
> I don't see a problem with doing that, but perhaps there is? Please
> elaborate if so.

You can set ecryptfs_sops->drop_inode to generic_delete_inode directly,
no?

			Pekka

