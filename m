Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVGDLIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVGDLIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 07:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGDLIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 07:08:43 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:42260 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261630AbVGDLAv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 07:00:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VOqSdz5O8i898XMsoaWBc80D0I+oMbSZf09RVP92H4ym1Sj8XEEyTIKiAxU2MEefnO7vmwW7+fDEzPqIaW7aPhnmrP5ea/97hk+GjeBYD7s9ZomKiGA6ezVUJJQ3HOA+slUcYlXF4rTStrBK+oJa76qpJmT69Hu89XrVZqdX6Jw=
Message-ID: <9a874849050704040068baf36e@mail.gmail.com>
Date: Mon, 4 Jul 2005 13:00:46 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Pekka Enberg <penberg@gmail.com>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020507040349e4b9723@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490507031832546f383a@mail.gmail.com>
	 <84144f020507040349e4b9723@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/05, Pekka Enberg <penberg@gmail.com> wrote:
> Hi Jesper,
> 
> On 7/4/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > static int
> > ibm_hdaps_open(struct inode *inode, struct file *filp)
> > {
> >       printk("%s() start\n", __func__);
> >       if (!atomic_dec_and_test(&ibm_hdaps_available)) {
> >               printk("%s() busy\n", __func__);
> >               atomic_inc(&ibm_hdaps_available);
> >               return -EBUSY;
> >       }
> >       printk("%s() good\n", __func__);
> >
> >       filp->private_data = kmalloc(sizeof(struct hdaps_accel_data), GFP_KERNEL);
> 
> You seem to be leaking private_data.
> 
Thanks. It still needs a lot of work (as can also be seen from all the
nice feedback in this thread).
I just woke up and I'll start looking at the mails people have posted
in a few hours.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
