Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAWJQF>; Tue, 23 Jan 2001 04:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAWJP4>; Tue, 23 Jan 2001 04:15:56 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:58891 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129735AbRAWJIL>; Tue, 23 Jan 2001 04:08:11 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: patl@curl.com (Patrick J. LoPresti)
Date: Tue, 23 Jan 2001 20:07:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14957.18908.887016.124180@notabene.cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Help: 2.2.18 NFS is corrupting our files
In-Reply-To: message from Patrick J. LoPresti on  January 22
In-Reply-To: <s5gvgr71xao.fsf@egghead.curl.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  January 22, patl@curl.com wrote:
> We have a LAN with about 40 Linux systems on it.  We use the Berkeley
> "customs" suite to perform parallelized builds of our product.  So we
> hammer NFS pretty hard; 30-40 machines can be simultaneously reading
> and writing a single build tree through NFS.
> 
> We upgraded one of our developers to 2.2.18.  We also upgraded all of
> our systems to the latest nfs-utils (0.2.1) and mount (2.10m) packages
> from <http://nfs.sourceforge.net/>.
> 
> As a result, we now have a large number of 2.2.17 NFS clients reading
> and writing to a 2.2.18 NFS server.  The server (the developer's
> desktop system) is SMP, and all of our systems have ECC memory.
> 
> This developer is now regularly seeing two problems which began with
> the 2.2.18 upgrade.  First, remote clients occasionally get "stale NFS
> file handle" errors for no apparent reason.  Second, some of the files
> are being corrupted.

Could you retry after applying patches from
    http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2/

particularly patch-B-sema.

Thanks,

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
