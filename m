Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264811AbRFSWQt>; Tue, 19 Jun 2001 18:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264814AbRFSWQj>; Tue, 19 Jun 2001 18:16:39 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18583 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264811AbRFSWQX>;
	Tue, 19 Jun 2001 18:16:23 -0400
Message-ID: <3B2FCF34.DDB9FAF4@mandrakesoft.com>
Date: Tue, 19 Jun 2001 18:16:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomasz =?iso-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre4
In-Reply-To: <E15CTVG-0006o0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > why not always -fno-builtin,
> > and then call __builtin_foo when we really want the compiler's version..

> That may well be the right thing to do. Of course we rely on the compiler
> providing some of them too

true, it wouldn't be a completely transparent switchover, but it seems
like the best way to produce expected results across a bunch of
different compilers.


> but -fno-builtin will still
> give a kernel that dosnt link due to abs() and other problems.. 8)

Any others come to mind?  abs is definitely special in that the compiler
[potentially] can do additional magic with the type information it has. 
Maybe -fno-builtin plus
	#undef abs
	#define abs __builtin_abs

Thanks,

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
