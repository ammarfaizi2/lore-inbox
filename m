Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271738AbRIGLmf>; Fri, 7 Sep 2001 07:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRIGLmZ>; Fri, 7 Sep 2001 07:42:25 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:22026 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S271738AbRIGLmL>; Fri, 7 Sep 2001 07:42:11 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Caleb Epstein <cae@bklyn.org>
Date: Fri, 7 Sep 2001 21:42:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15256.45720.351124.767983@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Spurious NFS ESTALE errors w/NFSv3 server, non-v3 client
In-Reply-To: message from Caleb Epstein on Thursday September 6
In-Reply-To: <20010906141117.B7579@tela.bklyn.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday September 6, cae@bklyn.org wrote:
> 
> 	I belive this is new behavior in the latest (post-2.4.7 I
> 	believe) kernel NFS software:
> 
> 	I have two machines, both running kernel 2.4.9, each of which
> 	act as both an NFS client and server to the other.  I am using
> 	the kernel NFS daemon and am exporting ext2fs filesystems on a
> 	local switched LAN.
> 
> 	One box, called tela, was configured with NFSv3 enabled for
> 	both the client and server code.  The other box, hagrid, was
> 	not configured with any NFSv3 support enabled.  I just neglected
> 	to enable this in the configuration, its was not for any
> 	particular reason.
> 
> 	When I did large file reads on hagrid (the v2 client), I
> 	would get spurious ESTALE errors on files which are totally
> 	static and haven't been
> 	touched in months.  Basically the filesystem contains a lot
> 	of audio files, and I was running md5 checksums on them from
> 	hagrid, while they were hosted on tela.

NFSv2 has a limit of 2Gigabytes per file.  Are the files that you are
reading close to, or exceeding, this size?

However, I wouldn't expect an ESTALE for that reason. 

Can you run "tcpdump -s 1024", the the response that contains the
error, and send the dozon or so lines around that?

NeilBrown
