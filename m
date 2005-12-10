Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVLJBdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVLJBdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 20:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVLJBdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 20:33:44 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:47255 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964828AbVLJBdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 20:33:44 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1134168222.5270.1.camel@bip.parateam.prv>
References: <1134154208.14363.8.camel@mindpipe>
	 <1134168222.5270.1.camel@bip.parateam.prv>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 09 Dec 2005 20:31:19 -0500
Message-Id: <1134178279.18432.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 23:43 +0100, Xavier Bestel wrote:
> Le vendredi 09 décembre 2005 à 13:50 -0500, Lee Revell a écrit :
> > I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> > I added -m64 to the CFLAGS as per the gcc docs. 
> 
> Under debian 32bits with 64bits kernel, I just add -m64 somewhere in the
> main Makefile to rebuild my modules. Didn't try with a whole kernel
> though.

The bug seems to be that the kernel build system does not grok biarch
toolchains - it really insists on a separate toolchain for i386 and
x86_64 even though the situation can be handled with selective use of
-m64.  If I jsut add -m64 to everything then it fails when it gets to
the ia32 stuff.

Lee

