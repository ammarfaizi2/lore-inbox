Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278962AbRKFKyU>; Tue, 6 Nov 2001 05:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278968AbRKFKyK>; Tue, 6 Nov 2001 05:54:10 -0500
Received: from pat.uio.no ([129.240.130.16]:48377 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S278962AbRKFKyF>;
	Tue, 6 Nov 2001 05:54:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15335.49462.641480.482777@charged.uio.no>
Date: Tue, 6 Nov 2001 11:53:42 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Bob Smart <smart@hpc.CSIRO.AU>, Pete Wyckoff <pw@osc.edu>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Red Hat needs this patch (was Re: handling NFSERR_JUKEBOX)
In-Reply-To: <Pine.LNX.4.21.0111060709380.9597-100000@freak.distro.conectiva>
In-Reply-To: <shswv14w9ps.fsf@charged.uio.no>
	<Pine.LNX.4.21.0111060709380.9597-100000@freak.distro.conectiva>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

     > Trond,

     > Should'nt we make Linux retry on NFSERR_JUKEBOX _by default_ ?

Normally we probably should. The thing that worries me is the fact
that we may be holding the VFS semaphores for long periods of
time. In particular that will greatly slow down lookups...
This is the reason why I'd prefer a lot of these things to be done in
the VFS layer or above.

Cheers,
  Trond
