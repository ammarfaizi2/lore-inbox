Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSCGBwt>; Wed, 6 Mar 2002 20:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCGBwk>; Wed, 6 Mar 2002 20:52:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60663 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289815AbSCGBwb>; Wed, 6 Mar 2002 20:52:31 -0500
Date: Wed, 6 Mar 2002 20:52:29 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020306205229.A15048@redhat.com>
In-Reply-To: <20020306182026.F866@redhat.com> <200203070127.UAA05891@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203070127.UAA05891@ccure.karaya.com>; from jdike@karaya.com on Wed, Mar 06, 2002 at 08:27:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 08:27:51PM -0500, Jeff Dike wrote:
> I showed the kernel build segfaulting as an improvement over UML hanging, 
> which is the alternative behavior.

Versus fully allocating the backing store, which would neither hang nor 
cause segfaults.  This is the behaviour that one expects by default, and 
should be the first line of defense before going to the overcommit model.  
Get that aspect of reliability in place, then add the overcommit support.  
What is better: having uml fail before attempting to boot with an unable 
to allocate backing store message, or a random oops during early kernel 
init?  As I see it, supporting the safe mode of operation first makes more 
sense before adding yet another arch hook.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
