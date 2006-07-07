Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWGGRCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWGGRCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGGRCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:02:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:40860 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932195AbWGGRCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:02:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DtYj4mz1yyMd8+YQAZyOJDgCQ8GAtsLZsyLsL+dSvdZxWsy8ZDIVUBi6U3YffFmpPDvbQ7gpSJvcyzKQM0cLEds4GPWTGdQYoRkb/f+2b//a8oKtxb6YBtZdx+nQQ3gc9xzrNWMOhEfFjlc4tytGoOwRdi1NknIHHPqYdKaSQjM=
Message-ID: <dda83e780607071002ibfe2514g720fa4bec092f8ed@mail.gmail.com>
Date: Fri, 7 Jul 2006 10:02:47 -0700
From: "Bret Towe" <magnade@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc1 bttv modprobe null pointer dereference
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060706233521.686300d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <dda83e780607062051x220841c7ya88ff0aefd5d3071@mail.gmail.com>
	 <20060706215225.290360bf.akpm@osdl.org>
	 <dda83e780607062219q1db55c58ga7eb1d5438635dcc@mail.gmail.com>
	 <20060706233521.686300d2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 6 Jul 2006 22:19:09 -0700
> "Bret Towe" <magnade@gmail.com> wrote:
>
> > > > Code: 4c 8b bf 48 01 00 00 48 8b bf c0 00 00 00 8b 5e 10 48 81 c7
> > > > RIP  [<ffffffff802f1f9b>] sysfs_add_file+0x2b/0xb0
> > > >  RSP <ffff81002ac71c28>
> > > > CR2: 0000000000000149
> > >
> > > There don't seem to have been significant changes in bttv-driver.c for some
> > > time, and we're seeing a few reports like this.  I'm suspecting that either
> > > a sysfs/driver-core change was wrong, or previously wrong driver behaviour
> > > is now causing oopses.
> > >
> > > And Mauro is offline until July 12.
> > >
> > > Can you send the .config please?
> >
> > of course
>
> I spent ten minutes and got lost.  I suspect videodev's class_device
> handling is wrong, but I fail to spot it.
>
> This might tell us something.

i dont see any new error messages in dmesg
looking at the trace it looks like its dieing before it gets to where this
patch would be used?
