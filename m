Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVIOUeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVIOUeI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVIOUeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:34:08 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:54397 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751190AbVIOUeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:34:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SM8ZpaW/1LSYznpxSdHJHbcxJfFIZp1Jx5HJvG/YvFwKnfCdn6Vd2Y62twKM5/O1KV+17GLnpm6racYAs3C96cRK1umvdiFc2F6TjgeC9hZ4whKRe0XNROizykuf7PXR0CVWpR8hmgeHoJk2AA8Idk/MATO3FfPEQmlXos3mr/Y=
Message-ID: <9a8748490509151334363cfd2d@mail.gmail.com>
Date: Thu, 15 Sep 2005 22:34:06 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: HZ question
Cc: Joe Bob Spamtest <joebob@spamtest.viacore.net>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200509152019.j8FKJvAD025249@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4326CAB3.6020109@compro.net>
	 <2cd57c9005091321006825540@mail.gmail.com>
	 <1126747237.13893.108.camel@mindpipe>
	 <43299E59.4060103@spamtest.viacore.net>
	 <200509152019.j8FKJvAD025249@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Thu, 15 Sep 2005 09:16:25 PDT, Joe Bob Spamtest said:
> > Lee Revell wrote:
> > > On Wed, 2005-09-14 at 12:00 +0800, Coywolf Qi Hunt wrote:
> > >
> > >>simply zgrep HZ= /proc/config.gz
> > >>on my box, I get CONFIG_HZ=1000
> > >
> > >
> > > Many distros inexplicably disable that by default.
> >
> > Their rationale is that knowing the kernel .config is a security threat.
> 
> At least in Fedora, they ship a mode 644 config file in /boot:
> 
> % ls -l /boot/config-2.6.13-1.1555_FC5
> 61 -rw-r--r--  1 root root 60135 Sep 14 15:55 /boot/config-2.6.13-1.1555_FC5
> 
> No need to include that in the kernel if it's right there on disk.  Even Fedora
> doesn't believe in *that* much bloat. ;)
> 

Or delete it from disk and include it in the kernel instead.

Having it in the kernel instead of as a sepperate file makes sense to
me; you'll never loose it as long as you have the actual kernel
around. Nothing like finding a problem with an older kernel and not
being able to duplicate the config with a newer one because you
deleted the .config at some point. With the config embedded in the
kernel that never happens...

As for the security issue with being able to read /proc/config.gz,
couldn't that be solved easily if that file had mode 0400 ?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
