Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRIWXdn>; Sun, 23 Sep 2001 19:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273692AbRIWXdd>; Sun, 23 Sep 2001 19:33:33 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:39951 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S273691AbRIWXdT>;
	Sun, 23 Sep 2001 19:33:19 -0400
Date: Mon, 24 Sep 2001 01:33:29 +0200
From: Jan Niehusmann <jan@gondor.com>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010924013328.A29582@gondor.com>
In-Reply-To: <11433641523.20010918175148@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11433641523.20010918175148@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:51:48PM +0300, VDA wrote:
> Since we don't have any negative feedback on Athlon bug
> stomper, I think patch could be applied to
> arch/i386/kernel/pci-pc.c in mainline kernel.

BTW, just for the statistics: On the Duron 600 machine, for which
I reported the athlon bug, the fix does not work. Register 0x55 has
a default value of 0x81, but setting it to 0x01 (as the fix does)
doesn't solve the problem, athlon optimised 2.4.9 kernels still fail
to run. 

But, OTOH, the computer in question regulary oopses on 2.4.0-test7 which
didn't have the athlon optimises page copy routine at all, so it may be
just a case of faulty hardware :-(

Jan

