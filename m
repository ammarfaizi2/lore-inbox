Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUCDEoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUCDEoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:44:22 -0500
Received: from terminus.zytor.com ([63.209.29.3]:51635 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261446AbUCDEoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:44:13 -0500
Message-ID: <4046B3F5.3070004@zytor.com>
Date: Wed, 03 Mar 2004 20:43:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linuxabi@zytor.com,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: [Linuxabi] Re: linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>	<200402292130.55743.mmazur@kernel.pl>	<c1tk26$c1o$1@terminus.zytor.com>	<200402292221.41977.mmazur@kernel.pl> <yw1xn0711sgw.fsf@kth.se>	<40434BD7.9060301@nortelnetworks.com>	<m37jy4cuaw.fsf@defiant.pm.waw.pl> <20040303152213.GA2148@mars.ravnborg.org>
In-Reply-To: <20040303152213.GA2148@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> IIRC the current agreed scheme is something along the lines of this:
> 
> abi/abi-linux/* Userspace relevant parts of include/linux
> abi/abi-asm/ symlink to abi/abi-$(ARCH)
> abi/abi-i386 i386 specific userland abi
> abi/abi-ppc  ppc ....
> 
> So a header file in include/linux with a counterpart in abi could look like this:
> 
> include/linux/wait.h:
> #include <abi-linux/wait.h>
> 
> #include <linux/config.h>
> typedef struct __wait_queue wait_queue_t;
> ...
> 
> 
> abi/abi-linux/wait.h:
> #define WNOHANG         0x00000001
> #define WUNTRACED       0x00000002
> 
> 
> This proposal meets some resistence related to internal issues such as
> renaming of internal types etc.
> But in the end the gain from a scheme like this outweights the drawbacks - IMHO. 
> 
> And the backward compatible stuff can be located in abi where it may belong -
> if really needed.
> 

I think the main issue is that it's going to take a fair amount of work, 
and hence needs to wait until 2.7.

The other thing to consider if whether or not there should be some way 
to export things that aren't easily expressible as #defines...

	-hpa
