Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbREMSHj>; Sun, 13 May 2001 14:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbREMSHT>; Sun, 13 May 2001 14:07:19 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:13060 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S263217AbREMSHL>;
	Sun, 13 May 2001 14:07:11 -0400
Date: Sun, 13 May 2001 11:07:07 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
Message-ID: <20010513110707.A11055@lucon.org>
In-Reply-To: <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m13da9ky7s.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, May 13, 2001 at 10:31:03AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 10:31:03AM -0600, Eric W. Biederman wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > On Fri, May 11, 2001 at 04:28:05PM -0700, David S. Miller wrote:
> > > 
> > > H . J . Lu writes:
> > >  > 2.4.4-ac8 disables IP auto config by default even if CONFIG_IP_PNP is
> > >  > defined.  Here is a patch.
> > > 
> > > It doesn't make any sense to enable this unless parameters are
> > > given to the kernel via the kernel command line or from firmware
> > > settings.
> > 
> > >From Configure.help:
> > 
> > IP: kernel level autoconfiguration
> > CONFIG_IP_PNP
> >   This enables automatic configuration of IP addresses of devices and
> >   of the routing table during kernel boot, based on either information
> >   supplied on the kernel command line or by BOOTP or RARP protocols.
> >   You need to say Y only for diskless machines requiring network 
> >   access to boot (in which case you want to say Y to "Root file system
> >   on NFS" as well), because all other machines configure the network 
> >   in their startup scripts.
> > 
> > It works fine for 2.4.4. However, in 2.4.4-ac8, even if I select
> > CONFIG_IP_PNP, I have to pass ip=xxxx to kernel, in addition to
> > nfsroot=x.x.x.x:/foo/bar. With 2.4.4, I can just pass
> > nfsroot=x.x.x.x:/foo/bar to kernel.
> 
> O.k. Configure.help needs to be updated. "ip=on" or "ip=bootp" or
> "ip=dhcp" work fine.  I wonder if I forgot to forward port the docs?

It doesn't make any senses. When I specify CONFIG_IP_PNP and
BOOTP/DHCP, I want a kernel with IP config using BOOTP/DHCP. I would
expect IP config is turned for BOOTP/DHCP by default. You can turn
it off by passing "ip=off" to kernel. Did I miss something?

> 
> This same situation exists for 2.2.18 & 2.2.19 as well.
> 
> The only way to get long term stability out of this is to write
> a user space client, you can put in a ramdisk.  One of these days...

It doesn't work with diskless machines which don't support ramdisk
during boot.


H.J.
