Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288683AbSADQrE>; Fri, 4 Jan 2002 11:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288682AbSADQqx>; Fri, 4 Jan 2002 11:46:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41990 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288681AbSADQqh>; Fri, 4 Jan 2002 11:46:37 -0500
Date: Fri, 4 Jan 2002 08:45:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>, <andries.brouwer@cwi.nl>
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <3C355143.8FAC281D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201040845130.5360-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Jeff Garzik wrote:
> >
> > Now, if somebody actually has the raw "kdev_t" in their on-disk
> > structures, that's a real problem, but I don't think anybody does.
> > Certainly I didn't see reiserfs do it (but it may well be missing a few
> > "kdev_t_to_nr()" calls)
>
> AFAICS it does:
>
> include/linux/reiserfs.h:
> #define sd_v1_rdev(sdp)         (le32_to_cpu((sdp)->u.sd_rdev))
> #define set_sd_v1_rdev(sdp,v)   ((sdp)->u.sd_rdev = cpu_to_le32(v))

Ok, just add the proper conversion functions, ie a "to_kdev_t()" and
"kdev_t_to_nr()".

		Linus

