Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261846AbSJNFop>; Mon, 14 Oct 2002 01:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSJNFoo>; Mon, 14 Oct 2002 01:44:44 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42455 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261846AbSJNFon>; Mon, 14 Oct 2002 01:44:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Date: Mon, 14 Oct 2002 15:50:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15786.23306.84580.323313@notabene.cse.unsw.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
In-Reply-To: message from Hirokazu Takahashi on Wednesday September 18
References: <20020918.171431.24608688.taka@valinux.co.jp>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 18, taka@valinux.co.jp wrote:
> Hello,
> 
> I ported the zerocopy NFS patches against linux-2.5.36.
> 

hi,
 I finally got around to looking at this.
 It looks good.

 However it really needs the MSG_MORE support for udp_sendmsg to be
 accepted before there is any point merging the rpc/nfsd bits.

 Would you like to see if davem is happy with that bit first and get
 it in?  Then I will be happy to forward the nfsd specific bit.

 I'm bit I'm not very sure about is the 'shadowsock' patch for having
 several xmit sockets, one per CPU.  What sort of speedup do you get
 from this?  How important is it really?

NeilBrown
