Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272644AbRIGNWq>; Fri, 7 Sep 2001 09:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272647AbRIGNWh>; Fri, 7 Sep 2001 09:22:37 -0400
Received: from [195.89.159.99] ([195.89.159.99]:13301 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272644AbRIGNW0>; Fri, 7 Sep 2001 09:22:26 -0400
Date: Fri, 7 Sep 2001 02:59:47 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
Message-ID: <20010907025947.E7329@kushida.degree2.com>
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>; from rothwell@holly-springs.nc.us on Thu, Sep 06, 2001 at 10:35:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:
> server# tail /var/log/messages
> Sep  6 09:37:43 gateway rpc.mountd: authenticated mount request from
> 192.168.1.133:933 for /export (/export)
> Sep  6 09:37:43 gateway rpc.mountd: getfh failed: Operation not permitted

I'm seeing this message quite often with one Linux 2.4.7 system
automounting another.  As long as A has B's filesystem mounted, all is
ok.  Then A times out, unmounts, and later wants to remount B's
filesystem.  Then, sometimes, I see a message much like yours.

It doesn't seem to need a reboot to cause this problem, and the fix I
have found is to kill and restart the NFS server: /etc/init.d/nfs
restart.

I have no idea why it happens, or why restarting nfsd or mountd fixes it.

-- Jamie
