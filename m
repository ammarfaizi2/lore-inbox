Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSHHCHi>; Wed, 7 Aug 2002 22:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSHHCHi>; Wed, 7 Aug 2002 22:07:38 -0400
Received: from mnh-1-02.mv.com ([207.22.10.34]:24581 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317257AbSHHCHi>;
	Wed, 7 Aug 2002 22:07:38 -0400
Message-Id: <200208080314.WAA04821@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Thu, 08 Aug 2002 03:27:04 +0200."
             <20020808032704.73d7fdda.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Aug 2002 22:14:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
> SIGIO would get delivered in the kernel and cleared from the shared
> pending queue, which is just what we want.

Not really.  What we really want is for signals not to be delivered at all.

That's why the ptrace signal annulling capability is nice.

I'm not sure if this makes any sense, but coupling the new aio mechanism with
something that queues up siginfos might be interesting.  It would be a magic
descriptor that would feed you signals when you read it.

Is that at all sane?

				Jeff

