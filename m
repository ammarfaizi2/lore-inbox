Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWBQJWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWBQJWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWBQJWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:22:04 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:22030 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932592AbWBQJWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:22:02 -0500
Date: Fri, 17 Feb 2006 17:21:54 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       autofs@linux.kernel.org
Subject: Re: [RFC:PATCH 4/4] autofs4 - add new packet type for v5 communications
In-Reply-To: <Pine.LNX.4.64.0602171703590.4109@eagle.themaw.net>
Message-ID: <Pine.LNX.4.64.0602171720240.4109@eagle.themaw.net>
References: <200602170701.k1H71Irp004035@eagle.themaw.net>
 <20060217005134.6842f0ca.akpm@osdl.org> <Pine.LNX.4.64.0602171703590.4109@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Ian Kent wrote:

> On Fri, 17 Feb 2006, Andrew Morton wrote:
> 
> > Ian Kent <raven@themaw.net> wrote:
> > >
> > > +/* autofs v5 common packet struct */
> > >  +struct autofs_v5_packet {
> > >  +	struct autofs_packet_hdr hdr;
> > >  +	autofs_wqt_t wait_queue_token;
> > >  +	__u32 dev;
> > >  +	__u64 ino;
> > >  +	uid_t uid;
> > >  +	gid_t gid;
> > >  +	pid_t pid;
> > >  +	pid_t tgid;
> > >  +	int len;
> > >  +	char name[NAME_MAX+1];
> > >  +};
> > 
> > Is this known to work with 32-bit userspace on 64-bit kernels?
> > 
> > In particular, perhaps the ?id_t's should become a type of known size and
> > alignment (u32 or u64)?
> > 
> 
> Yes. I take your point.
> 
> I used this for some time on my Ultra 2, which has this type of arch, 
> without problem. I increased the ino field from 32 to 64 bits since that 
> time and haven't since tested it.
> 
> I'm happy to change them to 64 bit if you believe it will avoid potential 
> problems?
> 

Come to think of it my sons has an AMD64 system with a 32 bit Fedora 
install on it. I'll test on that as well over the weekend.

Ian

