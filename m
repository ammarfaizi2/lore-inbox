Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbSLDQDb>; Wed, 4 Dec 2002 11:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbSLDQDb>; Wed, 4 Dec 2002 11:03:31 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37386
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266717AbSLDQDb>; Wed, 4 Dec 2002 11:03:31 -0500
Subject: Re: [PATCH] deprecate use of bdflush()
From: Robert Love <rml@ufl.edu>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3of82fuy9.fsf@defiant.pm.waw.pl>
References: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com>
	 <1038935401.994.9.camel@phantasy> <3DED0076.55B970DD@yahoo.com>
	 <m3of82fuy9.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1039018264.1509.3.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Dec 2002 11:11:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 20:12, Krzysztof Halasa wrote:

> So why don't we print the warning with 2.4 as well?

We should of.  Now its too late - we cannot start printing evil warnings
on existing 2.4 systems.

> I don't know if returning -EINVAL (= removing the call completely in 2.5)
> isn't better, though - does it have any compatibility implications?

Right now the call forces a do_exit(), so the application terminates. 
If we just returned `-EINVAL' the application might sit around doing
nothing.

	Robert Love

