Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRAYA36>; Wed, 24 Jan 2001 19:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135200AbRAYA3i>; Wed, 24 Jan 2001 19:29:38 -0500
Received: from p3EE3C781.dip.t-dialin.net ([62.227.199.129]:50188 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129441AbRAYA30>; Wed, 24 Jan 2001 19:29:26 -0500
Date: Thu, 25 Jan 2001 01:29:18 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Linux 2.2.18 nfs v3 server bug (was: Incompatible: FreeBSD 4.2 client, Linux 2.2.18 nfsv3 server, read-only export)
Message-ID: <20010125012918.A15282@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010123015612.H345@quadrajet.flashcom.com> <20010123162930.B5443@emma1.emma.line.org> <wuofwynsj5.fsf_-_@bg.sics.se> <20010123105350.B344@quadrajet.flashcom.com> <20010124041437.A28212@emma1.emma.line.org> <14958.28927.756597.940445@notabene.cse.unsw.edu.au> <20010124142002.A1405@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010124142002.A1405@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Wed, Jan 24, 2001 at 14:20:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Matthias Andree wrote:

> This looks better and it makes FreeBSD able to ls the directory, and on
> touch /mnt/try, I get EROFS on the client, so this is okay; however, the
> access reply does not include EXECUTE permissions which I find strange,
> since the client lists this:
> 

My fault. NFSv3 has a different permission partitioning than local file
systems have, I did not see that. So Linux does the right
thing for ACCESS with Neil's patch. Neil, could you submit that patch to
Alan or bless it for inclusion into 2.2.19(pre)? The FreeBSD people
could then sleep well again. :-)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
