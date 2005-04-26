Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVDZKMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVDZKMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVDZKJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:09:47 -0400
Received: from mail.dif.dk ([193.138.115.101]:53983 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261443AbVDZKIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:08:54 -0400
Date: Tue, 26 Apr 2005 12:08:33 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 4/7] dlm: configuration
In-Reply-To: <20050426064940.GE12096@redhat.com>
Message-ID: <Pine.LNX.4.62.0504261206300.8528@jjulnx.backbone.dif.dk>
References: <20050425151250.GE6826@redhat.com>
 <Pine.LNX.4.62.0504251749090.2941@dragon.hyggekrogen.localhost>
 <20050426064940.GE12096@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, David Teigland wrote:

> Date: Tue, 26 Apr 2005 14:49:40 +0800
> From: David Teigland <teigland@redhat.com>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
> Subject: Re: [PATCH 4/7] dlm: configuration
> 
> On Mon, Apr 25, 2005 at 05:53:49PM +0200, Jesper Juhl wrote:
> > On Mon, 25 Apr 2005, David Teigland wrote:
> 
> > > +static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
> > > +{
> > > +	ls->ls_global_id = simple_strtol(buf, NULL, 0);
> > > +	return len;
> > > +}
> >
> > What's the point of `len' in these two functions? 
> > You pass in `len`, don't use it at all, then return the value. I fail to 
> > see the usefulness. Why not just have the function return void and omit 
> > the `len' parameter?
> 
> Do I have a choice?  Aren't these stipulated by sysfs?
> 
Hmm, right you are. I simply did a quick scan through the code and 
commented on everything that seemed odd, I didn't look into it in too much 
detail (too much code, too little time), so I may also have flagged a few 
other things that are perfectly OK but just seemed odd on a quick pass.


-- 
Jesper Juhl

