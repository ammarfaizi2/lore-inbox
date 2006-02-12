Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWBLUPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWBLUPO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 15:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWBLUPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 15:15:14 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:41535 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750901AbWBLUPM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 15:15:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OjbEK6jXZ0rWUtZdxRuHbT9VlZWOR7r+HG2XjdzuL/ySbsNyJqPKNY5nGh2D6aCUC0SphdjxpoomUIwPJH+HyYULhehUOEZrYJqihSpqpSvWILKEJxCFyubmK4gcoBsMHHDk/9xXuhLBpVIiNn5tqnYTyNiDiq4ax8jYvGUlj+k=
Message-ID: <51ad2e0d0602121215w1f637cecwd8a4704c4a918994@mail.gmail.com>
Date: Sun, 12 Feb 2006 21:15:10 +0100
From: Bin Zhang <yangtze31@gmail.com>
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <87lkwgpiha.fsf@hardknott.home.whinlatter.ukfsn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
	 <87lkwgpiha.fsf@hardknott.home.whinlatter.ukfsn.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/06, Roger Leigh <rleigh@whinlatter.ukfsn.org> wrote:
> Roger Leigh <rleigh@whinlatter.ukfsn.org> writes:
>
> > When running a 2.6.16-rc2 kernel on a powerpc system (Mac Mini;
> > Freescale 7447A):
> >
> > $ date && touch f && ls -l f && rm -f f && date
> > Sun Feb 12 12:20:14 GMT 2006
> > -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 12:23
> > Sun Feb 12 12:20:14 GMT 2006
> >
> > Notice the timestamp is 3 minutes in the future compared with the
> > system time.  "make" is not a very happy bunny running on this kernel
> > due to every touched file being 3 minutes in the future.
>
> > In both these cases, the chrony NTP daemon is running, if that might
> > be a problem.
>
> Some further information:
> - this does not appear to affect i386 kernels
> - I have
>     CONFIG_HZ_250=y
>     CONFIG_HZ=250
>   in my .config; the full config is at
>   http://people.debian.org/~rleigh/config-2.6.16-rc2
>

I have in my config-2.6.16-rc2 (G4 1.2Ghz, 7447A)
CONFIG_HZ_1000=y
CONFIG_HZ=1000
and have
$ date && touch f && ls -l f && rm -f f && date
Sun Feb 12 21:08:43 CET 2006
-rw-r--r-- 1 zhang zhang 0 2006-02-12 21:08 f
Sun Feb 12 21:08:43 CET 2006

I don't have ntp daemon running (ntpdate at boot).

Regards,
Bin

>
> Regards,
> Roger
>
> --
> Roger Leigh
>                 Printing on GNU/Linux?  http://gutenprint.sourceforge.net/
>                 Debian GNU/Linux        http://www.debian.org/
>                 GPG Public Key: 0x25BFB848.  Please sign and encrypt your mail.
>
>
>
