Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVAONIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVAONIX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVAONIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:08:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:11669
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262272AbVAONIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:08:21 -0500
Subject: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tim Bird <tim.bird@am.sony.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Karim Yaghmour <karim@opersys.com>
In-Reply-To: <41E8543A.8050304@am.sony.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>
	 <41E8543A.8050304@am.sony.com>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 14:08:19 +0100
Message-Id: <1105794499.13265.247.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

</Flame off>

On Fri, 2005-01-14 at 15:22 -0800, Tim Bird wrote:
>  but not 1) supporting infrastructure for timestamping, managing event
>  data, etc., and 2) a static list of generally useful tracepoints.

Both points are well taken. Thats the essential minimum what
instrumentation needs.

I'd like to see this infrastructure usable for all kinds of
instrumentation mechanisms which are built in to the kernel already or
functions which are used for similar purposes in experimental trees and
other instrumentation related projects. 

This requires to seperate the backend from the infrastructure, so you
can chose from a set of backends which fit best for the intended use. 

One of those backends is LTT+relayfs. 
I really respect the work you have done there, but please accept that I
just see the limitations and try to figure out a way to make it more
generic and flexible before it is cemented into the kernel and makes it
hard to use for other interesting instrumentation aspects and maybe
enforces redundant implementation of infrastructure related
functionality.

E.g. tracking down timing related issues can make use from such
functionality if the infrastructure is provided seperately.
I guess a lot of developers would be happy to use it when it is already
around in the kernel and it can help testers for giving better
information to developers.

tglx


