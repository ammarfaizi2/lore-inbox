Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293686AbSCESbQ>; Tue, 5 Mar 2002 13:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293702AbSCESbG>; Tue, 5 Mar 2002 13:31:06 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17465 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293686AbSCESa4>; Tue, 5 Mar 2002 13:30:56 -0500
Date: Tue, 5 Mar 2002 13:30:54 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Dike <jdike@karaya.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020305133054.B432@redhat.com>
In-Reply-To: <3C84F449.8090404@zytor.com> <200203051812.NAA03363@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203051812.NAA03363@ccure.karaya.com>; from jdike@karaya.com on Tue, Mar 05, 2002 at 01:12:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 01:12:19PM -0500, Jeff Dike wrote:
> Really?  And you're unconcerned about the impact on the rest of the system
> of a UML grabbing (say) 128M of memory when it starts up?  Especially if it
> may never use it?

Honestly, I think that most people want to know if the system they've setup 
is overcommited at as early a point as possible: a UML failing at startup 
with out of memory is better than random segvs at some later point when the 
system is under load.  Refer to the principle of least surprise.  And if the 
user truely wants to disable that, well, you can give them a command line 
option to shoot themselves in the foot with.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
