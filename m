Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUCDQuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUCDQuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:50:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18314 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262010AbUCDQut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:50:49 -0500
Message-ID: <40475E5C.9020708@pobox.com>
Date: Thu, 04 Mar 2004 11:50:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linuxabi@zytor.com, Chris Friesen <cfriesen@nortelnetworks.com>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>	<200402292130.55743.mmazur@kernel.pl>	<c1tk26$c1o$1@terminus.zytor.com>	<200402292221.41977.mmazur@kernel.pl> <yw1xn0711sgw.fsf@kth.se>	<40434BD7.9060301@nortelnetworks.com>	<m37jy4cuaw.fsf@defiant.pm.waw.pl>	<20040303152213.GA2148@mars.ravnborg.org> <m3u115zxif.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3u115zxif.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> 
>>IIRC the current agreed scheme is something along the lines of this:
>>
>>abi/abi-linux/* Userspace relevant parts of include/linux
>>abi/abi-asm/ symlink to abi/abi-$(ARCH)
>>abi/abi-i386 i386 specific userland abi
>>abi/abi-ppc  ppc ....
> 
> 
> More efforts, no real effects.
> I don't think we need such an infrastructure.
> The normal headers should just be usable for user-space inclusion.

No, this is a big pain :)

The ABI headers shared with userspace need to be split from definitions 
that are only used in kernel space.  #ifdef __KERNEL__ is a source of 
frustration :)

	Jeff



