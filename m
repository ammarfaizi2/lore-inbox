Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270378AbTHGSrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270416AbTHGSrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:47:21 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:55559 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270378AbTHGSrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:47:20 -0400
Message-ID: <3F329E59.B3D2EB28@SteelEye.com>
Date: Thu, 07 Aug 2003 14:45:45 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Schubert <bernd-schubert@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21]: nbd ksymoops-report
References: <Pine.LNX.4.10.10308071245130.13289-100000@clements.sc.steeleye.com> <3F328DB9.4EF38D9A@SteelEye.com> <200308072040.58144.bernd-schubert@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert wrote:

> The debian /etc/init.d/nbd-client script calls this on stopping stopping nbd.
> To make nbd working again after this oops we always need to reboot now (found
> this out after my first mail), so I'm really looking for an alternative way
> of stopping nbd. Would 'killall nbd-client' work?

Yes, "killall -9 nbd-client" would work, and would avoid this problem.
This is how I generally stop nbd-client.


> If there is a way to prevent the reboot of the client, I can test it on monday
> on our cluster at work.

With the patch, you'll no longer see this oops or need to reboot, and
"nbd-client -d" will work as intended.

 
--
Paul
