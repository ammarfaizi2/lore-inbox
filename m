Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292321AbSBUFG6>; Thu, 21 Feb 2002 00:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292633AbSBUFGt>; Thu, 21 Feb 2002 00:06:49 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:20118 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S292321AbSBUFGg>; Thu, 21 Feb 2002 00:06:36 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Chow <davidchow@shaolinmicro.com>
Date: Thu, 21 Feb 2002 16:04:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15476.32747.865192.538172@notabene.cse.unsw.edu.au>
Cc: "Peter J. Braam" <braam@clusterfs.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, phil@off.net
Subject: Re: tmpfs, NFS, file handles
In-Reply-To: message from David Chow on  February 21
In-Reply-To: <20020220094649.X25738@lustre.cfs>
	<3C73D548.648C5D64@mandrakesoft.com>
	<20020220122116.C28913@lustre.cfs>
	<15476.10488.442232.634169@notabene.cse.unsw.edu.au>
	<1014266633.17471.8.camel@star9.planet.rcn.com.hk>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  February 21, davidchow@shaolinmicro.com wrote:
> 
> What I suggest is nfsd should export a symbol called
> generic_fh_to_dentry() such that it will be more generic like
> generic_file_read() to handle gneeric calls for every fs.

But every filesystem is really very different in this reguard.

What would you think this "generic_fh_to_dentry" should do?

We actually already have one.  You set ->fh_to_dentry to NULL, and the
it used "iget". 

NeilBrown
