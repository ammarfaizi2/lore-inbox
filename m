Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280351AbRKEIPD>; Mon, 5 Nov 2001 03:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280344AbRKEIOx>; Mon, 5 Nov 2001 03:14:53 -0500
Received: from brev.stud.ntnu.no ([129.241.56.70]:48301 "EHLO
	brev.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S280342AbRKEIOi>; Mon, 5 Nov 2001 03:14:38 -0500
Date: Mon, 5 Nov 2001 09:14:22 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: knfsd error ?
Message-ID: <20011105091422.C23683@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some days ago I mentioned a couple of problems with the eepro100-driver,
after a lot of input and testing, it seems like it's a fault in the nfs-code
somewhere.

Testing was done with one nfs-server, running linux 2.4.13 and one
nfs-client (either a Dell PowerEdge 2550 with 1GB RAM and Intel EEpro100
network card, or a Sun Enterprise 450 with 4GB RAM and hme-interface).
Running bonnie++ on the solaris-server over a nfs-mounted share:

Sun Solaris 8 [nfs-client] <-> Linux [nfs-daemon]

3Com-NIC in server: NFS-timeout after some minutes when doing "Writing
                    intelligently"-test. Max. throughput of 8.5MB/s
EEpro100 in server: NFS-timeout after some minutes when doing "Writing
                    intelligently"-test. Max. throughput of 8.5MB/s


Linux [nfs-client] <-> Linux [nfs-daemon]

3Com-NIC in server: Everything was fine, no errors whatsoever. Max.
                    throughput of 11MB/s.
EEpro100 in server: Everything was fine, no errors whatsoever. Max.
                    throughput of 11MB/s


I'd be glad to help figure out _why_ we get nfs-timeout when we do sun
solaris <-> linux. Just tell me what to run or do :)

If you need any more info about setup and tests, please tell me, and I'll be
glad to provide the details.

-- 
Thomas
