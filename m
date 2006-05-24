Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWEXDMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWEXDMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 23:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWEXDMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 23:12:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:39290 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932556AbWEXDMK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 23:12:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OQmngf0Aa59Pcf4CHk8rjx863DaMDXq+nG5xznRGwLXMa4Ce4b1FRd9mKW1JQNzpsdC+CiFyN/EtnhF+QPzmJVlILh3Cp+720az4Wuecu6c4uX3sAmGpcP6atHLzQJqLQg66hY/+Edx+xWDUaJOx8tQZ8qdVxF2/CjBV/bVnr2o=
Message-ID: <661de9470605232012j1bf44c5ane50b84c6b0d43445@mail.gmail.com>
Date: Wed, 24 May 2006 08:42:09 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [Patch 0/6] statistics infrastructure
Cc: "Martin Peschke" <mp3@de.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060523144258.0938c4d3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060519092411.6b859b51.akpm@osdl.org> <44733F7B.9070009@de.ibm.com>
	 <20060523144258.0938c4d3.akpm@osdl.org>
X-Google-Sender-Auth: d49b698655934e06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> > Andrew,
> >
> > taskstats, Balbir'r approach, is too specific and doesn't work for me.
> > It is by design limited to per-task data.
>
> OK.  They are pretty different things.
>
> Balbir, do you see any sane way in which the APIs you've implemented can be
> extended to cover this requirement?

I'll work with Martin on that. If Martin decides to move to
netlink/genetlink we could search for some common ground w.r.t to
transfering data to user space, but IMHO its going to be hard, our API
is meant to be used in task context. I think both the statistics
target different use cases (one is device driver oriented and the
other is task oriented)

>
> > My statistics code is not limited to per-task statistics, but allows exploiters
> > to have data been accumulated and been shown for whatever entity they need to,
> > may it be for tasks, for SCSI disks, per adapter, per queue, per interface,
> > for a device driver, etc.
>
> OK.
>
> > If you want me to change my code to use netlink anyway, I might be able to
> > implement my own genetlink family. I haven't look at the details of that yet.
> >
>
> Well, a debugfs interface _should_ be OK.  If not, why do we need debugfs?
>
> Ho hum, hard.  Please send the patches again, let's take a closer look, see
> if we can move them forward a bit.
>

Warm Regards,
Balbir
Linux Technology Center,
India Software Labs,
Bangalore
