Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280606AbRKBJBD>; Fri, 2 Nov 2001 04:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280610AbRKBJAx>; Fri, 2 Nov 2001 04:00:53 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:19644
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S280606AbRKBJAp>; Fri, 2 Nov 2001 04:00:45 -0500
Message-ID: <3BE270ED.7050109@debian.org>
Date: Fri, 02 Nov 2001 11:09:49 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] Is this a bug?
In-Reply-To: <fa.l396uov.18jgog6@ifi.uio.no> <fa.dvj9vsv.1b4k8ip@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Also (in a separate patch at the end) is the removal of a whole bunch of:
> 
> #ifdef IP2DEBUG_TRACE
> 	ip2trace(foo);
> #endif
> 
> and replacing it with (the Linus-preferred, and far cleaner):
> 
> #ifdef IP2DEBUG_TRACE
> void ip2trace(foo)
> #else
> #define ip2trace(foo) do {} while (0)
> #endif
> 

Why in Linux we use "do {} while (0)" instead of the
standard "(void)0" ?
(standard = as normal libc in <assert.h>)

do while(0) is used for multiple statment macro to avoid problem
in if-else, not for empty instructions.


	giacomo

