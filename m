Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272304AbRIKHHU>; Tue, 11 Sep 2001 03:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272305AbRIKHHL>; Tue, 11 Sep 2001 03:07:11 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:50436 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272304AbRIKHGz>; Tue, 11 Sep 2001 03:06:55 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Date: Tue, 11 Sep 2001 17:06:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15261.47090.893483.500877@notabene.cse.unsw.edu.au>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: message from Jamie Lokier on Friday September 7
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<20010907025947.E7329@kushida.degree2.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 7, lk@tantalophile.demon.co.uk wrote:
> Michael Rothwell wrote:
> > server# tail /var/log/messages
> > Sep  6 09:37:43 gateway rpc.mountd: authenticated mount request from
> > 192.168.1.133:933 for /export (/export)
> > Sep  6 09:37:43 gateway rpc.mountd: getfh failed: Operation not permitted
> 
> I'm seeing this message quite often with one Linux 2.4.7 system
> automounting another.  As long as A has B's filesystem mounted, all is
> ok.  Then A times out, unmounts, and later wants to remount B's
> filesystem.  Then, sometimes, I see a message much like yours.
> 
> It doesn't seem to need a reboot to cause this problem, and the fix I
> have found is to kill and restart the NFS server: /etc/init.d/nfs
> restart.
> 
> I have no idea why it happens, or why restarting nfsd or mountd fixes it.

Show me your /etc/exports....

If you export a directory and a subdirectory of that directory - both
on the same filesysem, you can get this.
If you export a directory to both an IP address (or subnet) and a
hostname (or wildcard or netgroup) this can also happen.

NeilBrown
