Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUBRUoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUBRUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:44:11 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:61322 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S267370AbUBRUoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:44:06 -0500
Subject: Re: [NET] 64 bit byte counter for 2.6.3
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: root@chaos.analogic.com
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.53.0402181527000.7318@chaos>
References: <1077123078.9223.7.camel@midux>
	 <20040218101711.25dda791@dell_ss3.pdx.osdl.net>
	 <Pine.LNX.4.53.0402181527000.7318@chaos>
Content-Type: text/plain
Message-Id: <1077137014.18843.10.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 22:43:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 22:32, Richard B. Johnson wrote:
> Manipulation of a 'long long' is not atomic in 32 bit architectures.
> Please explain how we don't care, if we shouldn't care. Also some
> /proc entries might get read incorrectly with existing tools.
Please, tell me all the tools, I'll test them. ifconfig and netstat
works correctly atleast.

And about the caring, is rx/tx bytes so important that they can't use
long long? I would care to see more than 4GB, and maybe some error in
the counter at some point (Have you _ever_ seen that happen?) than only
4GB.

And no, I didn't post this to be merged into the mainline kernel, just
to let users know that there maybe is an option for seeing maximum 4GB.

This has been working for me since, umm.. let's say 2.4.20. All the
tools I've needed have worked.

        Markus

