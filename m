Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276058AbRJBRw1>; Tue, 2 Oct 2001 13:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRJBRwR>; Tue, 2 Oct 2001 13:52:17 -0400
Received: from mons.uio.no ([129.240.130.14]:36064 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S276058AbRJBRwG>;
	Tue, 2 Oct 2001 13:52:06 -0400
MIME-Version: 1.0
Message-ID: <15289.65245.126409.37240@charged.uio.no>
Date: Tue, 2 Oct 2001 19:52:29 +0200
To: Andreas Schwab <schwab@suse.de>
Cc: Ian Grant <Ian.Grant@cl.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 build failure - atomic_dec_and_lock export
In-Reply-To: <jepu86j8rm.fsf@sykes.suse.de>
In-Reply-To: <E15oRJg-00005z-00@wisbech.cl.cam.ac.uk>
	<shs669yvwty.fsf@charged.uio.no>
	<jepu86j8rm.fsf@sykes.suse.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andreas Schwab <schwab@suse.de> writes:

     > Trond Myklebust <trond.myklebust@fys.uio.no> writes:
     > |> If you have CONFIG_SMP defined then atomic_dec_and_lock will
     > |> never get defined

     > Unless you use CONFIG_MODVERSIONS, which causes
     > atomic_dec_and_lock to be versioned and defined as a macro via
     > <linux/modversions.h>.

Oh great... That's going to confound the test in <linux/spinlock.h>
too.

Urgh. Can anybody propose a less ugly solution than EXPORT_SYMBOL_NOVERS()?

Cheers,
   Trond
