Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWFXDom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWFXDom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 23:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWFXDol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 23:44:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:20321 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932109AbWFXDol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 23:44:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2GL3y/J2UoddsvSfVjBwKuEUtcPXba+Ta32O0eAs0Z63+/lAFdMG+4Ks7K3mVN1TKedJfdWn3ElFA3AuFWMMENr2yzwvEpOquaF5jnW89byHLuDxZ3qwpmRfroQzY8AMSqoS46yJm7RwCPHfacu02GS/CkzcnT56Gg+90n2K2E=
Message-ID: <1e1a7e1b0606232044x11136be5p332716b757ecd537@mail.gmail.com>
Date: Sat, 24 Jun 2006 13:44:39 +1000
From: James <iphitus@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] fcache: a remapping boot cache
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <20060531061234.GC29535@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de>
	 <20060516074628.GA16317@suse.de>
	 <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com>
	 <20060531061234.GC29535@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set this up on my laptop yesterday with some awesome results. I'm
using 2.6.17-ck1 which has v2.1.

Heres some bootcharts, before, after, and a prime run.

http://archlinux.org/~james/normal.png
http://archlinux.org/~james/fs-fcache.png
http://archlinux.org/~james/fs-fcache-prime.png

Repeated boots show about the same 6 second improvement, 32 down to 26
seconds. Looking at the slowdowns in the fs-fcache run, most are due
to cpu load, waiting on network or, modprobe, and not disk access. X
now starts nearly instantaneously.

As an experiment, I primed my cache right through to logging into my
desktop environment. It was so effective, that now when I login, the
GNOME splash screen only flickers onto the screen briefly, and the
panels appear almost instantly. This is a big improvment over without
fcache, where you'd see each component of GNOME being loaded on the
splash screen, nautilus, metacity, and the panels would take quite a
bit of time to render and load all their applets.

Impressive work, I hope to see it broadened to other filesystems,
improved and merged to vanilla soon because it has clear improvements.

James
-- 
iphitus - Beyond Maintainer, Arch Trusted User, Arch Developer.
Home:iphitus.loudas.com
