Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbVGHXYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVGHXYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVGHXYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:24:00 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:33730 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262981AbVGHXWR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:22:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kzXRg7uIc6xDTiq4c9w5sBOsMeWiObRckCiBs3wrHLu9yPP5uvY2xvsx9IdzRJAhGlsNMBJHYRfIS95KEZLosy/KhDmdAabszCdHqDCKil2hDBvPHD+IPXM4Ru9XRtiaAXqFWFcgPx80iB37iJpuNv/3swIUZTyRpqrSi4OSU3Y=
Message-ID: <29495f1d0507081622470fbd07@mail.gmail.com>
Date: Fri, 8 Jul 2005 16:22:15 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/4] drivers/char/ip2/i2lib.c: replace direct assignment with set_current_state()
Cc: domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
In-Reply-To: <20050708160824.10d4b606.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050707213138.184888000@homer>
	 <20050708160824.10d4b606.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/05, Andrew Morton <akpm@osdl.org> wrote:
> domen@coderock.org wrote:
> >
> > @@ -655,7 +655,7 @@ i2QueueCommands(int type, i2ChanStrPtr p
> >                       timeout--;   // So negative values == forever
> >
> >               if (!in_interrupt()) {
> 
> I worry about what this driver is trying to do...
> 
> > -                     current->state = TASK_INTERRUPTIBLE;
> > +                     set_current_state(TASK_INTERRUPTIBLE);
> >                       schedule_timeout(1);    // short nap
> 
> We do this all over the place.  Adding new schedule_timeout_interruptible()
> and schedule_timeout_uninterruptible() would reduce kernel size and neaten
> things up.

I'll get a patch and users set up soon to do just this.

Thanks,
Nish
