Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbREMQeL>; Sun, 13 May 2001 12:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbREMQeB>; Sun, 13 May 2001 12:34:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30252 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261417AbREMQds>; Sun, 13 May 2001 12:33:48 -0400
To: "H . J . Lu" <hjl@lucon.org>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
In-Reply-To: <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2001 10:31:03 -0600
In-Reply-To: "H . J . Lu"'s message of "Fri, 11 May 2001 16:53:39 -0700"
Message-ID: <m13da9ky7s.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" <hjl@lucon.org> writes:

> On Fri, May 11, 2001 at 04:28:05PM -0700, David S. Miller wrote:
> > 
> > H . J . Lu writes:
> >  > 2.4.4-ac8 disables IP auto config by default even if CONFIG_IP_PNP is
> >  > defined.  Here is a patch.
> > 
> > It doesn't make any sense to enable this unless parameters are
> > given to the kernel via the kernel command line or from firmware
> > settings.
> 
> >From Configure.help:
> 
> IP: kernel level autoconfiguration
> CONFIG_IP_PNP
>   This enables automatic configuration of IP addresses of devices and
>   of the routing table during kernel boot, based on either information
>   supplied on the kernel command line or by BOOTP or RARP protocols.
>   You need to say Y only for diskless machines requiring network 
>   access to boot (in which case you want to say Y to "Root file system
>   on NFS" as well), because all other machines configure the network 
>   in their startup scripts.
> 
> It works fine for 2.4.4. However, in 2.4.4-ac8, even if I select
> CONFIG_IP_PNP, I have to pass ip=xxxx to kernel, in addition to
> nfsroot=x.x.x.x:/foo/bar. With 2.4.4, I can just pass
> nfsroot=x.x.x.x:/foo/bar to kernel.

O.k. Configure.help needs to be updated. "ip=on" or "ip=bootp" or
"ip=dhcp" work fine.  I wonder if I forgot to forward port the docs?

This same situation exists for 2.2.18 & 2.2.19 as well.

The only way to get long term stability out of this is to write
a user space client, you can put in a ramdisk.  One of these days...

Eric
