Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbRFWWoS>; Sat, 23 Jun 2001 18:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbRFWWoH>; Sat, 23 Jun 2001 18:44:07 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:529 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262997AbRFWWn6>; Sat, 23 Jun 2001 18:43:58 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Hans-Joachim Baader <hjb@pro-linux.de>
Date: Sun, 24 Jun 2001 08:43:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15157.7074.925308.323744@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two nfsd bugs in 2.4.x
In-Reply-To: message from Hans-Joachim Baader on Sunday June 24
In-Reply-To: <20010624000750.D2868@mandel.hjb.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday June 24, hjb@pro-linux.de wrote:
> Hi,
> 
> Since I switched to the kernel nfsd I have troubles exporting my
> filesystems. I think in kernel 2.2.x there was no problem, neither was
> it with the userspace nfsd. Currently I run kernel 2.4.5pre1 on the
> server.

Sounds like you might have an old nfs-utils package.  Try the latest
(nfs.sourceforget.net) and see if that helps.

If it doesn't, please provide complete /etc/exports and /etc/fstab.

NeilBrown


> 
> 1. When I try to boot one of my diskless clients (kernel 2.0.34), it mounts
> its root fs from /opt/boot/client which is on an ext2 fs. But apparently
> it hangs when it tries to access lib/ld-linux.so.1 (seen with a network
> sniffer). This is a symbolic link pointing to lib/ld-linux.so.1.9.2.
> In the kernel log I find:
> 
> nfsd Security: lib/ld-linux.so.1 bad export.
> 
> 2. I cannot any longer mount the server's /usr on certain workstations.
> It works on my main workstation which currently runs kernel 2.4.5.
> On other workstations I get "permission denied by server". I tried various
> kernels (2.0.36, 2.2.3, 2.3.52) and various versions of mount (2.7l, 2.10o).
> My /etc/exports contains the line
> 
> /usr            *.hjb.de(rw,no_root_squash)
> 
> and all my clients are in my local DNS. The syslog shows
> 
> rpc.mountd: getfh failed: Operation not permitted
> 
> Any help? More info on request.
> 
> Thanks,
> hjb
> -- 
> Pro-Linux - Germany's largest volunteer Linux support site
> http://www.pro-linux.de/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
