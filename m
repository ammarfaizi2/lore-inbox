Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267613AbUBRSR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267750AbUBRSRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:17:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267613AbUBRSRY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:17:24 -0500
Date: Wed, 18 Feb 2004 10:17:11 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [NET] 64 bit byte counter for 2.6.3
Message-Id: <20040218101711.25dda791@dell_ss3.pdx.osdl.net>
In-Reply-To: <1077123078.9223.7.camel@midux>
References: <1077123078.9223.7.camel@midux>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 18:51:19 +0200
Markus Hästbacka <midian@ihme.org> wrote:

> Ok, Here's a patch for 64 bit byte counters for 2.6.3. For any intrested
> users to try.
> 
> That means in english that the limit for RX bytes and TX bytes (in
> ifconfig for example) is much higher than the old 4GB limit on 32 bit
> systems.
> 
> Orginal patch by Miika Pekkarinen, ported forward from 2.5 by me.
> 
> Patch says 2.6.3-rc1, but patches cleanly on 2.6.3.
> 
>         Markus

Some quick comments:
 * Network changes gets discussed on netdev@oss.sgi.com 
 * 64 bit values are not atomic on 32 bit architectures 
 * wider values in /proc output risks breaking apps like ifconfig and netstat
