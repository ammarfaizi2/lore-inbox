Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbTE1USX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTE1USX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:18:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52359 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264861AbTE1USV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:18:21 -0400
Date: Wed, 28 May 2003 16:34:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux390@de.ibm.com, James Antill <jantill@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch for strncmp use in s390 in 2.5
In-Reply-To: <20030528162019.A3492@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.53.0305281631440.14073@chaos>
References: <20030528162019.A3492@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Pete Zaitcev wrote:

> Martin & others:
>
> I didn't see this posted before. Sorry if I missed it.
> It's a harmless buglet which causes false positives with correctness
> checking tools, and so annoys me.
>
> Cheers,
> -- Pete

Maybe it should be changed to memcmp() with the null-byte included
in the length since the compare length is already defined in the code.
This should reduce the overhead at the same time it gets rid
of the false positive.

[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

