Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272651AbRIGN14>; Fri, 7 Sep 2001 09:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272653AbRIGN1i>; Fri, 7 Sep 2001 09:27:38 -0400
Received: from cc853160-b.vron1.nj.home.com ([24.10.112.73]:32265 "EHLO
	tela.bklyn.org") by vger.kernel.org with ESMTP id <S272651AbRIGN1c>;
	Fri, 7 Sep 2001 09:27:32 -0400
Date: Fri, 7 Sep 2001 09:27:47 -0400
From: Caleb Epstein <cae@bklyn.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Spurious NFS ESTALE errors w/NFSv3 server, non-v3 client
Message-ID: <20010907092747.A24283@tela.bklyn.org>
Reply-To: Caleb Epstein <cae@bklyn.org>
In-Reply-To: <20010906141117.B7579@tela.bklyn.org> <15256.45720.351124.767983@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15256.45720.351124.767983@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Organization: Brooklyn Dust Bunny Mfg.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 09:42:16PM +1000, Neil Brown wrote:

> NFSv2 has a limit of 2Gigabytes per file.  Are the files that you are
> reading close to, or exceeding, this size?

	Not that large, no.  They're on the order of tens of
	megabytes, maybe 150 MBytes max.

> However, I wouldn't expect an ESTALE for that reason.  Can you run
> "tcpdump -s 1024", the the response that contains the error, and
> send the dozon or so lines around that?

	See below for the end of the tcpdump log, which concludes with
	the ESTALE.  I've got the entire log saved, which is about 1.4
	MB gzipped, available as http://bklyn.org/~cae/tcpdump.log.gz

	For this test, server was linux 2.4.9 w/nfsv3 enabled, client
	was 2.4.7 with no nfsv3.  Filesystem mounted on the client as:

tela:/shn on /shn/tela type nfs (rw,rsize=8192,wsize=8192,soft,addr=192.168.1.2,addr=192.168.1.2)

	Let me know if I can provide any add'l info that might help.

09:24:16.191079 tela.bklyn.org.nfs > hagrid.bklyn.org.2225077128: reply ok 96 write (DF)
09:24:16.191107 hagrid.bklyn.org > tela.bklyn.org: (frag 33381:1332@2960)
09:24:16.191116 hagrid.bklyn.org > tela.bklyn.org: (frag 33381:1480@1480+)
09:24:16.191131 hagrid.bklyn.org.2275408776 > tela.bklyn.org.nfs: 1472 write fh Unknown/1 4096 (4096) bytes @ 94208 (94208) (frag 33381:1480@0+)
09:24:16.204605 tela.bklyn.org.nfs > hagrid.bklyn.org.2241854344: reply ok 96 write (DF)
09:24:16.204632 hagrid.bklyn.org > tela.bklyn.org: (frag 33382:1332@2960)
09:24:16.204640 hagrid.bklyn.org > tela.bklyn.org: (frag 33382:1480@1480+)
09:24:16.204656 hagrid.bklyn.org.2292185992 > tela.bklyn.org.nfs: 1472 write fh Unknown/1 4096 (4096) bytes @ 102400 (102400) (frag 33382:1480@0+)
09:24:16.212418 tela.bklyn.org.nfs > hagrid.bklyn.org.2258631560: reply ok 96 write (DF)
09:24:16.212443 hagrid.bklyn.org > tela.bklyn.org: (frag 33383:988@7400)
09:24:16.212451 hagrid.bklyn.org > tela.bklyn.org: (frag 33383:1480@5920+)
09:24:16.212463 hagrid.bklyn.org > tela.bklyn.org: (frag 33383:1480@4440+)
09:24:16.212480 hagrid.bklyn.org > tela.bklyn.org: (frag 33383:1480@2960+)
09:24:16.212485 hagrid.bklyn.org > tela.bklyn.org: (frag 33383:1480@1480+)
09:24:16.212492 hagrid.bklyn.org.2308963208 > tela.bklyn.org.nfs: 1472 write fh Unknown/1 8192 (8192) bytes @ 110592 (110592) (frag 33383:1480@0+)
09:24:16.220518 tela.bklyn.org.nfs > hagrid.bklyn.org.2275408776: reply ok 96 write (DF)
09:24:16.220542 hagrid.bklyn.org > tela.bklyn.org: (frag 33384:988@7400)
09:24:16.220550 hagrid.bklyn.org > tela.bklyn.org: (frag 33384:1480@5920+)
09:24:16.220562 hagrid.bklyn.org > tela.bklyn.org: (frag 33384:1480@4440+)
09:24:16.220580 hagrid.bklyn.org > tela.bklyn.org: (frag 33384:1480@2960+)
09:24:16.220587 hagrid.bklyn.org > tela.bklyn.org: (frag 33384:1480@1480+)
09:24:16.220594 hagrid.bklyn.org.2325740424 > tela.bklyn.org.nfs: 1472 write fh Unknown/1 8192 (8192) bytes @ 118784 (118784) (frag 33384:1480@0+)
09:24:16.228087 tela.bklyn.org.nfs > hagrid.bklyn.org.2292185992: reply ok 96 write (DF)
09:24:16.235465 tela.bklyn.org.nfs > hagrid.bklyn.org.2308963208: reply ok 96 write (DF)
09:24:16.246145 tela.bklyn.org.nfs > hagrid.bklyn.org.2325740424: reply ok 96 write (DF)
09:24:16.246286 hagrid.bklyn.org.2342517640 > tela.bklyn.org.nfs: 184 read fh Unknown/1 4096 bytes @ 39305216 (DF)
09:24:16.246631 tela.bklyn.org.nfs > hagrid.bklyn.org.2342517640: reply ok 28 read ERROR: Stale NFS file handle (DF)

-- 
cae at bklyn dot org | Caleb Epstein | bklyn . org | Brooklyn Dust Bunny Mfg.
