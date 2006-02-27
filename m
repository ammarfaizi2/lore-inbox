Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWB0JFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWB0JFX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWB0JFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:05:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751672AbWB0JFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:05:20 -0500
Subject: Re: GFS2 Filesystem [1/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <84144f020602251348t3ea1420du4e84ac012e9d7909@mail.gmail.com>
References: <1140792745.6400.710.camel@quoit.chygwyn.com>
	 <84144f020602251348t3ea1420du4e84ac012e9d7909@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 27 Feb 2006 09:10:19 +0000
Message-Id: <1141031419.6400.798.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the feedback and now added to out todo list along with your
earlier comments,

Steve.

On Sat, 2006-02-25 at 23:48 +0200, Pekka Enberg wrote:
> On 2/24/06, Steven Whitehouse <swhiteho@redhat.com> wrote:
> > +/*  Divide num by den.  Round up if there is a remainder.  */
> > +#define DIV_RU(num, den) (((num) + (den) - 1) / (den))
> 
> Seems generally useful. Consider putting this to <linux/kernel.h> and
> giving it a better name e.g. DIV_ROUND_UP.
> 
> > +#define get_v2sdp(sb) ((struct gfs2_sbd *)(sb)->s_fs_info)
> > +#define set_v2sdp(sb, sdp) (sb)->s_fs_info = (sdp)
> > +#define get_v2ip(inode) ((struct gfs2_inode *)(inode)->u.generic_ip)
> > +#define set_v2ip(inode, ip) (inode)->u.generic_ip = (ip)
> > +#define get_v2fp(file) ((struct gfs2_file *)(file)->private_data)
> > +#define set_v2fp(file, fp) (file)->private_data = (fp)
> > +#define get_v2bd(bh) ((struct gfs2_bufdata *)(bh)->b_private)
> > +#define set_v2bd(bh, bd) (bh)->b_private = (bd)
> > +
> > +#define get_transaction ((struct gfs2_trans *)(current->journal_info))
> > +#define set_transaction(tr) (current->journal_info) = (tr)
> > +
> > +#define get_gl2ip(gl) ((struct gfs2_inode *)(gl)->gl_object)
> > +#define set_gl2ip(gl, ip) (gl)->gl_object = (ip)
> > +#define get_gl2rgd(gl) ((struct gfs2_rgrpd *)(gl)->gl_object)
> > +#define set_gl2rgd(gl, rgd) (gl)->gl_object = (rgd)
> > +#define get_gl2gl(gl) ((struct gfs2_glock *)(gl)->gl_object)
> > +#define set_gl2gl(gl, gl2) (gl)->gl_object = (gl2)
> 
> Consider dropping these macros. Please note redundant casting.
> 
> > +#define gfs2_inum_equal(ino1, ino2) \
> > +       (((ino1)->no_formal_ino == (ino2)->no_formal_ino) && \
> > +       ((ino1)->no_addr == (ino2)->no_addr))
> 
> Consider using static inline function instead.
> 
> > +#define DT2IF(dt) (((dt) << 12) & S_IFMT)
> > +#define IF2DT(sif) (((sif) & S_IFMT) >> 12)
> 
> Ditto.
> 
>                                               Pekka

