Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137036AbREKXx5>; Fri, 11 May 2001 19:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137069AbREKXxr>; Fri, 11 May 2001 19:53:47 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:19463 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S137036AbREKXxl>;
	Fri, 11 May 2001 19:53:41 -0400
Date: Fri, 11 May 2001 16:53:39 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
Message-ID: <20010511165339.A12289@lucon.org>
In-Reply-To: <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15100.30085.5209.499946@pizda.ninka.net>; from davem@redhat.com on Fri, May 11, 2001 at 04:28:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 04:28:05PM -0700, David S. Miller wrote:
> 
> H . J . Lu writes:
>  > 2.4.4-ac8 disables IP auto config by default even if CONFIG_IP_PNP is
>  > defined.  Here is a patch.
> 
> It doesn't make any sense to enable this unless parameters are
> given to the kernel via the kernel command line or from firmware
> settings.

>From Configure.help:

IP: kernel level autoconfiguration
CONFIG_IP_PNP
  This enables automatic configuration of IP addresses of devices and
  of the routing table during kernel boot, based on either information
  supplied on the kernel command line or by BOOTP or RARP protocols.
  You need to say Y only for diskless machines requiring network 
  access to boot (in which case you want to say Y to "Root file system
  on NFS" as well), because all other machines configure the network 
  in their startup scripts.

It works fine for 2.4.4. However, in 2.4.4-ac8, even if I select
CONFIG_IP_PNP, I have to pass ip=xxxx to kernel, in addition to
nfsroot=x.x.x.x:/foo/bar. With 2.4.4, I can just pass
nfsroot=x.x.x.x:/foo/bar to kernel.


H.J.
