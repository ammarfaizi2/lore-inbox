Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287833AbSBCWpJ>; Sun, 3 Feb 2002 17:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287841AbSBCWo6>; Sun, 3 Feb 2002 17:44:58 -0500
Received: from mons.uio.no ([129.240.130.14]:2557 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S287833AbSBCWoy>;
	Sun, 3 Feb 2002 17:44:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15453.48475.123973.610574@charged.uio.no>
Date: Sun, 3 Feb 2002 23:44:43 +0100
To: "=?iso-8859-2?Q?Burj=E1n_G=E1bor?=" 
	<buga+dated+1013031263.c89449@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 NFS hangup
In-Reply-To: <20020203213422.GA703@csoma.elte.hu>
In-Reply-To: <20020203202251.GA22797@csoma.elte.hu>
	<shsbsf61di3.fsf@charged.uio.no>
	<20020203213422.GA703@csoma.elte.hu>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm... pcnet32.c seems to engage in some dubious practices. Look for
instance at the way it can call pcnet32_restart() from within the
interrupt handler.

Are you seeing any kernel log messages about 'Tx FIFO error!' that
might indicate that particular code is getting triggered?

Cheers,
  Trond
