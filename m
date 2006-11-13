Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754661AbWKMOAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbWKMOAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbWKMOAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:00:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:3544 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754661AbWKMOAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:00:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IauhdqLlHo1yIbSy17lZ94OS2vvfggEoELPcogz8qp9diRwcyPVeyt8hmwdTN+V8nWvQgoa4Myc0cQpUR4Zmy1mLUeYMy9zenURCJTiuEH0MHYhl8wZmTruZi7m2cvZwjcfnth72QD8g3D1JKl5pdloYZ5P110iyH7nzfCx7ASo=
Message-ID: <9a8748490611130600m3b63349eu53b437da5c75a775@mail.gmail.com>
Date: Mon, 13 Nov 2006 15:00:39 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Shaun Q" <shaun@c-think.com>
Subject: Re: Dual cores on Core2Duo not detected?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/06, Shaun Q <shaun@c-think.com> wrote:
> Hi there everyone --
>
> I'm trying to build a custom kernel for using both cores of my new
> Core2Duo E6600 processor...
>
> I thought this was simply a matter of enabling the SMP support in the
> kernel .config and recompiling, but when the kernel comes back up, still
> only one core is detected.
>
> With the default vanilla text-based SuSE 10.1 install, it does find both
> cores...
>
> Anyone have any pointers for me on what I might be missing?
>

This is probably not your problem, but it could be, so worth checking.
Are you booting with  maxcpus=1  on your kernel commandline?

Another thing could be that you need to set CONFIG_NR_CPUS to
something more than 2. at least in the past some people observed that
depending on hov CPUs/cores got numbered CONFIG_NR_CPUS needed to be
set at least as high as the highest numbered core. Try setting it to 8
and see if that makes a difference.

On a related note; you probably also want to enable CONFIG_SCHED_MC in
addition to just SMP support.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
