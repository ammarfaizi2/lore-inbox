Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUATCyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUATCuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:50:10 -0500
Received: from [218.93.20.101] ([218.93.20.101]:3478 "EHLO mail.shinco.com")
	by vger.kernel.org with ESMTP id S265253AbUATCrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:47:00 -0500
Date: Tue, 20 Jan 2004 10:47:00 +0800
From: Peng Yong <ppyy@bentium.com>
To: linux-kernel@vger.kernel.org
Subject: Re: system resource limit in kernel 2.6
In-Reply-To: <20040109182450.462bc537.akpm@osdl.org>
References: <20040110095333.0765.PPYY@bentium.com> <20040109182450.462bc537.akpm@osdl.org>
Message-Id: <20040120104423.1E71.PPYY@bentium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peng Yong <ppyy@bentium.com> wrote:
> >
> > 
> > We upgrade one of our production http server, runing apache 1.3.29, to
> > kernel 2.6. some time the main process of apache exit and here is the
> > error log:
> > 
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > 
> > 
> > how can i tuning the kernel and remove the system resource limit?
> > 
> 
> Well the question is: why did behaviour change relative to 2.4?  The kernel
> is saying that uid 65534 has exceeded its RLIMIT_NPROC threshold.
> 
> How may processes is user 65534 actually running, and how much memory does
> the machine have?


we also find a report in the apache user list for the same problem:

http://marc.theaimsgroup.com/?l=apache-httpd-users&m=107330742328001&w=2

now we downgrade the kernel to 2.4.22 with security patch,  all works
fine now.

