Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273233AbRIJGzh>; Mon, 10 Sep 2001 02:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273237AbRIJGz1>; Mon, 10 Sep 2001 02:55:27 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:5636 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S273233AbRIJGzO>; Mon, 10 Sep 2001 02:55:14 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
Date: Mon, 10 Sep 2001 16:55:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15260.25562.278698.458611@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: message from Michael Rothwell on Friday September 7
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<15256.46017.7716.689482@notabene.cse.unsw.edu.au>
	<000c01c1379c$c427c0d0$81d4870a@cartman>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 7, rothwell@holly-springs.nc.us wrote:
> 
> Just wondering if there's been any talk, plans, etc. of an alternative for
> NFS.
> 
> > What exactly do you mean by "better" anyway?
> 
> Better security, better performance.
> 
> Thanks,
> 
> -M

NFSv2 and 3 do allow better security, but it isn't often implemented.
I am working on putting some infrastructure in place so that
crypto-authentication can be added to nfsd in a nice modular way.
Ofcourse the client will need to speak the same authentication
protocol too.

Then there is NFSv4 which might improve performance in some
circumstances, though it could do more....

SUNs "cachefs" concept can be used to improve read performance by
caching a lot more of server-data on the client.  That could be
implemented for Linux, but I don't know of anyone with serious plans.

NeilBrown
