Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTESXFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTESXFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:05:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16394 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263373AbTESXFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:05:19 -0400
Message-ID: <3EC9660D.2000203@zytor.com>
Date: Mon, 19 May 2003 16:17:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>	<babhik$sbd$1@cesium.transmeta.com>	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com> <m18yt235cf.fsf@frodo.biederman.org>
In-Reply-To: <m18yt235cf.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>
>>ABI fixes and ABI additions, as well as outright ABI changes (yes they
>>suck, but they happen.) 
> 
> And ABI changes from the ABI exposed by a stable kernel are _B_U_G_S.
> Yes _b_u_g_s happen but they are still _b_u_g_s.
> 
> It is legal to stop supporting an interface but changing the interface
> in such a way that you must know the version of the kernel you are
> running on is a _b_u_g.
> 

Yes.  And guess what?  Bugs happen.  Sometimes you can't fix them either
because the "new" usage has gotten established.  However, that's not the
point.

Your message assumes that the ABI remains fixed.  This is totally and
utterly and undeniably WRONG.  There are rules for how it may evolve,
but it very much does evolve.  No amount of handwaving or putting
underscores in weird places will change that.

> 
> But there is no reason not to write documentation today about what the
> kernel interfaces are and convert glibc and the kernel later when
> it is convenient to their development cycles.  
> 
> What I do not is see the necessity of using automation to follow the
> documentation.
> 

Otherwise you have three places to manually make your changes (usually
more) -- the documentation, the kernel, and glibc... and really you also
have klibc, uclibc, dietlibc, and God knows what else.

Automation is the way to maintain these together and in concert, to
avoid your "B_ U_ G_ S_."  This isn't just a Good Thing, this is the
only sane possibility.

Does that mean C source code is the only possible format?  It most
certainly *doesn't* -- in fact one could argue it's not even a very good
format -- as long as C source code is one of the possible productions.

	-hpa


