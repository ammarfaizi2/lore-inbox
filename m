Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319091AbSHFOHM>; Tue, 6 Aug 2002 10:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319088AbSHFOGg>; Tue, 6 Aug 2002 10:06:36 -0400
Received: from jdike.solana.com ([198.99.130.100]:33408 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S319086AbSHFOGe>;
	Tue, 6 Aug 2002 10:06:34 -0400
Message-Id: <200208061412.g76ECPB13837@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Tue, 06 Aug 2002 15:04:47 +0200."
             <20020806150447.2af350b0.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Aug 2002 10:12:25 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
> Does this work for you? 

No :-)

> It doesn't for me, for the reason I described
> earlier.

Indeed.  I misread the !capable(CAP_KILL) as "I am not allowed to kill the
other guy", which clearly you are when you just forked it.

This looks like a bug to me.  If you own the process, you can send it any
signal you want, so you should be allowed to sign it up for SIGURG/SIGIO via
F_SETOWN.

				Jeff

