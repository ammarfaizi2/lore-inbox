Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267511AbSKSWos>; Tue, 19 Nov 2002 17:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267522AbSKSWos>; Tue, 19 Nov 2002 17:44:48 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:11214 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267511AbSKSWor>; Tue, 19 Nov 2002 17:44:47 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Date: Wed, 20 Nov 2002 09:51:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15834.49275.238123.495190@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: rpc.mountd problem in 2.5.48
In-Reply-To: message from Peter Chubb on Tuesday November 19
References: <15834.1952.674371.221691@wombat.chubb.wattle.id.au>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 19, peter@chubb.wattle.id.au wrote:
> 
> Hi,
> 	After installing 2.5.48, I see lots and lots of messages like these:
> Nov 19 20:17:24 wombat rpc.mountd: authenticated mount request from xterm.chubb.wattle.id.au:916 for /usr/local/xenginenew/fonts/misc (/usr) 
> Nov 19 20:17:24 wombat rpc.mountd: getfh failed: Operation not permitted 
> 
> These weren't there in 2.5.44. What's changed?

Lots of stuff.... but nothing that I can connect this to.
Also, I cannot reproduce it.

> xterm uses version 2 NFS; /etc/exports says:
> ..
> /usr	*.chubb.wattle.id.au(rw,sync,no_root_squash)
> ..
> /usr is ext2:
> $ mount
> /dev/sda5 on /usr type ext2 (rw)
> 
> 
> If I add the `insecure' option things work again; but this didn't used
> to be necessary.  And the log shows it coming in on port 916,
> anyway.

I suspec that adding 'insecure' did not fix the problem, but rather it
was trying again that fixed the problem.

Does /etc/exports have any exports to IP address rather than hostname?
Which version of nfs-utils are you using?

NeilBrown
