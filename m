Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRJBNKx>; Tue, 2 Oct 2001 09:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273783AbRJBNKn>; Tue, 2 Oct 2001 09:10:43 -0400
Received: from alf.zfn.uni-bremen.de ([134.102.20.22]:57766 "EHLO
	alf.zfn.uni-bremen.de") by vger.kernel.org with ESMTP
	id <S273709AbRJBNKc>; Tue, 2 Oct 2001 09:10:32 -0400
Date: Tue, 2 Oct 2001 15:10:51 +0200
From: Christof Efkemann <efkemann@uni-bremen.de>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830 support for agpgart
Message-Id: <20011002151051.488306ee.efkemann@uni-bremen.de>
In-Reply-To: <1001988137.2780.53.camel@phantasy>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de>
	<1001988137.2780.53.camel@phantasy>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Oct 2001 22:02:08 -0400
Robert Love <rml@tech9.net> wrote:

> You don't need all that code.  If agp_try_unsupported works, then
> intel_generic_setup works, so you don't need an intel_830_setup.
> 
> In other words, if agp_try_unsupported=1 makes everything OK, then you
> just need to add the detection code.
> 
> Thus, the patch becomes the following.  Give that a try.

Yes, that seems to work as well.  Although there are two minor things I
noticed:
- First, intel_generic_setup sets num_aperture_sizes to 7, while the i830
  has only 4 valid values (32 to 256 MB).
- Second, when intel_generic_configure clears the error status register, it
  resets bits 8, 9 and 10.  With an i830 it should clear bits 2, 3 and 4.

So I'm not sure if this works in general, or could it cause errors on other
systems?

-- 
Regards,
Christof Efkemann
