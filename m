Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSHHCSC>; Wed, 7 Aug 2002 22:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSHHCSC>; Wed, 7 Aug 2002 22:18:02 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:25842 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317232AbSHHCSC>; Wed, 7 Aug 2002 22:18:02 -0400
Date: Wed, 7 Aug 2002 22:21:42 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Dike <jdike@karaya.com>
Cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-ID: <20020807222142.B26110@redhat.com>
References: <20020808032704.73d7fdda.us15@os.inf.tu-dresden.de> <200208080314.WAA04821@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208080314.WAA04821@ccure.karaya.com>; from jdike@karaya.com on Wed, Aug 07, 2002 at 10:14:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 10:14:42PM -0500, Jeff Dike wrote:
> I'm not sure if this makes any sense, but coupling the new aio mechanism with
> something that queues up siginfos might be interesting.  It would be a magic
> descriptor that would feed you signals when you read it.
> 
> Is that at all sane?

Delivering signals from aio completion is indeed possible.  There is 
even a field in the iocb structure for doing this in order to provide 
complete posix compatibility (well, except for the fact that structure 
initialization is enforced).

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
