Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130529AbRCFMMB>; Tue, 6 Mar 2001 07:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbRCFMLw>; Tue, 6 Mar 2001 07:11:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55816 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130529AbRCFMLc>; Tue, 6 Mar 2001 07:11:32 -0500
Subject: Re: kmalloc() alignment
To: prumpf@mandrakesoft.com (Philipp Rumpf)
Date: Tue, 6 Mar 2001 12:14:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kenn@linux.ie (Kenn Humborg),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <20010306025931.A12655@mandrakesoft.mandrakesoft.com> from "Philipp Rumpf" at Mar 06, 2001 02:59:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aGLt-0000ZB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are people who assume 16byte alignment guarantees. I dont think anyone
> > has formally specified the guarantee beyond 4 bytes tho
> 
> Userspace malloc is "suitably aligned for any kind of variable", so I think
> expecting 8 bytes alignment (long long on 32-bit platforms) should be okay.
> 
> >From reading the code it seems as though we actually use L1_CACHE_BYTES,
> and I think it might be a good idea to document the current behaviour (as
> long as there's no good reason to change it ?)

With slab poisoning I dont belive this is true
