Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271042AbTGVXa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 19:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271044AbTGVXa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 19:30:29 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:27120 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271042AbTGVXa2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 19:30:28 -0400
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1DB75E.1050906@kolumbus.fi>
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>
	 <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>
	 <3F1D7C80.6020605@gibraltar.at>
	 <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>
	 <3F1DB75E.1050906@kolumbus.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1058917089.4768.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 00:38:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-22 at 23:14, Mika Penttilä wrote:
> /sbin/init used to start up with files->count > 1 and does 
> close(0);close(1);close(2); -> kernel thread fds close.
> 
> Now with unshare_files() and init's files->count ==1 the kernel threads  
> /dev/console fds remain open. But one could ask of course so what :)

In other words the kernel side got caught out because it assumed 
the bogus thread behaviour and needs some close() calls adding. That
would make sense.


