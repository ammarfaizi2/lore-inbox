Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291443AbSBSPKO>; Tue, 19 Feb 2002 10:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291441AbSBSPKD>; Tue, 19 Feb 2002 10:10:03 -0500
Received: from ns.suse.de ([213.95.15.193]:51725 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291440AbSBSPJw>;
	Tue, 19 Feb 2002 10:09:52 -0500
Date: Tue, 19 Feb 2002 16:09:46 +0100
From: Dave Jones <davej@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        zwane@linux.realnet.co.sz
Subject: Re: gnome-terminal acts funny in recent 2.5 series
Message-ID: <20020219160946.K8293@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Alessandro Suardi <alessandro.suardi@oracle.com>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
	zwane@linux.realnet.co.sz
In-Reply-To: <3C719641.3040604@oracle.com> <87d6z11ys8.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87d6z11ys8.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Tue, Feb 19, 2002 at 08:44:39PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 08:44:39PM +0900, OGAWA Hirofumi wrote:
 > --- socket.c.orig	Mon Feb 11 18:21:59 2002
 > +++ socket.c	Tue Feb 19 16:20:18 2002
 > @@ -501,6 +501,8 @@ struct socket *sock_alloc(void)
 >  	sock->ops = NULL;
 >  	sock->sk = NULL;
 >  	sock->file = NULL;
 > +//	init_waitqueue_head(&sock->wait);	this is needed?
 > +	sock->passcred = 0;

 The first line is dead since 2.5.4, but the second is the important
 bit here. And as well as fixing the gnome-terminal weirdness, it
 also fixes the 'portmapper slows box to a crawl' problem, that
 Zwane, myself and rth saw..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
