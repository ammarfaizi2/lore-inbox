Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUJDSt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUJDSt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUJDStG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:49:06 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:50834 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268306AbUJDStB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:49:01 -0400
Message-ID: <41619B74.8070802@tmr.com>
Date: Mon, 04 Oct 2004 14:50:28 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH / RFC] Shared Reed-Solomon ECC Library
References: <1096670893.25635.41.camel@thomas>
In-Reply-To: <1096670893.25635.41.camel@thomas>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> Hi,
> 
> the attached patch contains a shared Reed-Solomon Library analogous to
> the shared zlib.
> 
> (N)AND FLASH is gaining popularity and there are a lot of ASIC/SoC/FPGA
> controllers around which implement hardware support for Reed-Solomon
> error correction. As usual they use different implementations
> (polynomials etc.). So it's obvious to use a shared library for the
> common tasks of error correction.
> 
> A short scan through the kernel revealed that at least the ftape driver
> uses Reed-Solomon error correction. It could be easily converted to use
> the shared library code. 
> 
> The encoder/decoder code is lifted from the GPL'd userspace RS-library
> written by Phil Karn. I modified/wrapped it to provide the different
> functions which we need in the MTD/NAND code.
> 
> The library is tested in extenso under various MTD/NAND configurations.
> 
> The lib should be usable for other purposes right out of the box.
> Adjustment for currently not implemented functionality is an easy task.
> 
> I'm willing to take the maintainership of the library.

One use would be very reliable CD/DVD for backup. I believe there's a 
freshmeat project which addresses this problem, but a reliable optical 
device certainly sounds easy using this approach.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
