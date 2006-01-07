Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWAGB3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWAGB3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWAGB27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:28:59 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:50765 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030306AbWAGB27 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:28:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FIxahvB+vAaJC+tFoWMmtk2kWpWXuPvDEmfNKshlNlddjIrebtcnnYPnVzd1zNSDB/JO3hN370i45dFlk2GoOx+qQXznfSD8i/jRqIYwiqIc/RAROZij/vF1sGenCAJzSd87dapwOMxZxHl5kyJUHYhhuVFzoGG4pR/TMY9b4DQ=
Message-ID: <9a8748490601061728x66fd3a76mecedde0c3a4c4b93@mail.gmail.com>
Date: Sat, 7 Jan 2006 02:28:58 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, airlied@linux.ie
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
In-Reply-To: <9a8748490601061720k228eec1dr2afcfdc7ece6c862@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	 <20060105162714.6ad6d374.akpm@osdl.org>
	 <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
	 <20060105165946.1768f3d5.akpm@osdl.org>
	 <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com>
	 <20060107002833.GB9402@redhat.com>
	 <20060106164012.041e14b2.akpm@osdl.org>
	 <20060107005712.GF9402@redhat.com>
	 <9a8748490601061720k228eec1dr2afcfdc7ece6c862@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 1/7/06, Dave Jones <davej@redhat.com> wrote:
>
> > Jesper: http://lkml.org/lkml/2006/1/4/534
> > (unmunged diff is at http://lkml.org/lkml/diff/2006/1/4/534/1)
> >
> Thanks, I'll apply that (and raise the timeout somewhat, since 2min is
> far from enough time for me to write down an entire Oops by hand -
> wouldn't it be better if it simply spun in a loop until some magic key
> (like enter, esc, break or something) is pressed? Then you have all
> the time you might need).
>

btw: your patch is missing a small bit. You need to #include
<linux/nmi.h> in arch/i386/kernel/traps.c or you'll get

arch/i386/kernel/traps.c: In function `show_registers':
arch/i386/kernel/traps.c:300: warning: implicit declaration of
function `touch_nmi_watchdog'


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
