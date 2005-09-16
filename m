Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVIPVjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVIPVjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIPVjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:39:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35806 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751294AbVIPVjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:39:18 -0400
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, Miklos Szeredi <miklos@szeredi.hu>,
       mike@waychison.com, bfields@fieldses.org, serue@us.ibm.com
In-Reply-To: <20050916142557.691b055e.akpm@osdl.org>
References: <20050916182619.GA28428@RAM>
	 <20050916142557.691b055e.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1126906755.4693.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Sep 2005 14:39:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 14:25, Andrew Morton wrote:
> linuxram@us.ibm.com (Ram) wrote:
> >
> > Lindentified fs/namespace.c
> 
> For something which is as already-close to CodingStyle as namespace.c it's
> probably better to tidy it up by hand.  Lindent breaks almost as much stuff
> as it fixes.

I thought Lindent was the gospel for codying style. Looks like its not.
Will fix all of them.

RP
> 
> > -static void *m_start(struct seq_file *m, loff_t *pos)
> > +static void *m_start(struct seq_file *m, loff_t * pos)
> 
> As Ben said.
> 
> >  	list_for_each(p, &n->list)
> > -		if (!l--)
> > -			return list_entry(p, struct vfsmount, mnt_list);
> > +	    if (!l--)
> > +		return list_entry(p, struct vfsmount, mnt_list);
> 
> Indenting with four spaces is a bit of a pain.  Presumably because Lindent
> doesn't know what list_for_each() does.
> 
> > -static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> > +static void *m_next(struct seq_file *m, void *v, loff_t * pos)
> 
> Again.
> 
> >  struct seq_operations mounts_op = {
> > -	.start	= m_start,
> > -	.next	= m_next,
> > -	.stop	= m_stop,
> > -	.show	= show_vfsmnt
> > +	.start = m_start,
> > +	.next = m_next,
> > +	.stop = m_stop,
> > +	.show = show_vfsmnt
> >  };
> 
> Arguable.
> 
> > -repeat:
> > +      repeat:
> 
> Labels go in column zero.
> 
> > -dput_and_out:
> > +      dput_and_out:
> 
> ugh, here it went and inserted spaces.
> 
> > -	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
> > -		;
> > +	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;
> 
> Regression!
> 
> > -	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
> > +	error =
> > +	    __user_walk(new_root, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new_nd);
> 
> ug.
> 
> > ...
> 
> etc.
> 
> One approach is to run Lindent, then go through the diff and fix it up by
> hand.  Then apply the patch and fix up the remaining Lindent mistakes by
> hand.  But the raw output of Lindent isn't right.

