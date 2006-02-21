Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWBULWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWBULWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWBULWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:22:46 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:32746 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932215AbWBULWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:22:45 -0500
Date: Tue, 21 Feb 2006 12:22:44 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Lang <dlang@digitalinsight.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
Message-ID: <20060221112244.GB30135@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	David Lang <dlang@digitalinsight.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com> <m1pslystkz.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr> <m1r76c2yhf.fsf@ebiederm.dsl.xmission.com> <9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com> <Pine.LNX.4.61.0602101420550.31246@yvahk01.tjqt.qr> <Pine.LNX.4.62.0602151238520.5446@qynat.qvtvafvgr.pbz> <Pine.LNX.4.61.0602171737530.27452@yvahk01.tjqt.qr> <Pine.LNX.4.62.0602171201020.8348@qynat.qvtvafvgr.pbz> <m17j7toeac.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j7toeac.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 02:39:55PM -0700, Eric W. Biederman wrote:
> David Lang <dlang@digitalinsight.com> writes:
> 
> > I agree that the mojority of users don't hit this limit, but I've
> > got a couple of boxes that push it (they run out of ram before that,
> > but more ram is on order).
> >
> > however it sounds like switching to a 64 bit kernel will avoid this
> > limit, so I'll put my efforts into configuring a box to do that.
>
> That is what I would recommend. Unless you do something weird an
> painful like configure a kernel doing the 4G/4G split a 32bit box is
> going to have memory problems with more than 32K tasks.

or configure the newly introduced 2.13/1.87 (or 1/3 split)

I don't think low memory is really the issue here, the
scheduling of 32k+ tasks is much more a problem ...

best,
Herbert

> Just remember you need push up /proc/sys/kernel/pid-max to raise the
> default on a 64bit box.
> 
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
