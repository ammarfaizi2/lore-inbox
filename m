Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262930AbREaAZe>; Wed, 30 May 2001 20:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbREaAZO>; Wed, 30 May 2001 20:25:14 -0400
Received: from intranet.resilience.com ([209.245.157.33]:56502 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262930AbREaAZJ>; Wed, 30 May 2001 20:25:09 -0400
Mime-Version: 1.0
Message-Id: <p05100316b73b3f2e80e2@[10.128.7.49]>
In-Reply-To: <9f41vq$our$1@cesium.transmeta.com>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>
 <9f41vq$our$1@cesium.transmeta.com>
Date: Wed, 30 May 2001 17:24:37 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: How to know HZ from userspace?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:07 PM -0700 2001-05-30, H. Peter Anvin wrote:
>  > If you now want to set those values from a userspace program / script in
>>  a portable manner, you need to be able to find out of HZ of the currently
>>  running kernel.
>>
>
>Yes, but that's because the interfaces are broken.  The decision has
>been that these values should be exported using the default HZ for the
>architecture, and that it is the kernel's responsibility to scale them
>when HZ != USER_HZ.  I don't know if any work has been done in this
>area.

FWIW (perhaps not much in this context), the POSIX way is sysconf(_SC_CLK_TCK)

POSIX sysconf is pretty useful for this kind of thing (not just HZ, either).
-- 
/Jonathan Lundell.
