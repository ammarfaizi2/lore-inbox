Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbSK1V3C>; Thu, 28 Nov 2002 16:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266817AbSK1V3C>; Thu, 28 Nov 2002 16:29:02 -0500
Received: from mx2.elte.hu ([157.181.151.9]:1728 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266750AbSK1V3A>;
	Thu, 28 Nov 2002 16:29:00 -0500
Date: Thu, 28 Nov 2002 22:36:12 +0100
From: KELEMEN Peter <fuji@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS performance ...
Message-ID: <20021128213612.GB6321@chiara.elte.hu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <200211241521.09981.m.c.p@wolk-project.de> <20021128110627.GD26875@chiara.elte.hu> <shs65uh1wch.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <shs65uh1wch.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) [20021128 17:40]:

> > The culprit turned out to be an inherited CONFIG_NFS_DIRECTIO
> > setting.  Having the client kernel (2.4.20rc2aa1) this option
> > turned off, performance is stable 4 MB/sec (server hasn't
> > changed).  This is almost twice as good as with 2.4.19-rmap14b.

> Huh? Sounds like something is seriously screwed up in your
> kernel build then. CONFIG_NFS_DIRECTIO should should result in 2
> things only: [...] None of the ordinary NFS read and write code
> paths should be affected by the above.

Well, weird as it may seem, this is what happened.  I compiled
2.4.20rc2aa1 with my .config, NFS sucked.  make menuconfig, turned
off CONFIG_NFS_DIRECTIO, make -j2 bzImage modules modules_install
(no compiler errors), install kernel, lilo, reboot, NFS flies.
Confirmed on other machine as well.  gcc is 3.2.1 (Debian sid).
Wish to seek more input on the case?

Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'
