Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTB1M1P>; Fri, 28 Feb 2003 07:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbTB1M1P>; Fri, 28 Feb 2003 07:27:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11409
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267812AbTB1M1O>; Fri, 28 Feb 2003 07:27:14 -0500
Subject: Re: Protecting processes from the OOM killer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E5EB9A8.3010807@kegel.com>
References: <3E5EB9A8.3010807@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 13:40:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 01:21, Dan Kegel wrote:
> For a while now, I've been trying to figure out how
> to make the oom killer not kill important processes.

How about by not allowing your system to excessively overcommit.
Everything else is armwaving "works half the time" stuff. By the time
the OOM kicks in the game is already over. The rlimit one doesnt deal
with things like fork explosions where you have lots of processes
all under 1/4 of the rlimit range who cumulatively overcommit. In
fact you now pick harder on other tasks...

