Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270542AbUJUDED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270542AbUJUDED (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270529AbUJUDAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:00:25 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:46860 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S270512AbUJUC4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:56:39 -0400
Date: Thu, 21 Oct 2004 10:53:12 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
Subject: Re: [ANNOUNCE] iproute2 2.6.9-041019
In-Reply-To: <20041020091554.57e60936@zqx3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0410211049400.4927@boston.corp.fedex.com>
References: <41758014.4080502@osdl.org> <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
 <20041020091554.57e60936@zqx3.pdx.osdl.net>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/21/2004
 10:56:36 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/21/2004
 10:56:37 AM,
	Serialize complete at 10/21/2004 10:56:37 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Oct 2004, Stephen Hemminger wrote:

> Try this, ss was dragging in byteorder.h and it didn't need to.
>
> diff -Nru a/misc/ss.c b/misc/ss.c
> --- a/misc/ss.c	2004-10-20 09:13:56 -07:00
> +++ b/misc/ss.c	2004-10-20 09:13:56 -07:00
> @@ -33,7 +33,6 @@
> #include "libnetlink.h"
> #include "SNAPSHOT.h"
>
> -#include <asm/byteorder.h>
> #include <linux/tcp.h>
> #include <linux/tcp_diag.h>


same problem.

"#include <linux/tcp.h>" is dragging in "#include <asm/byteorder.h>".

Same thing goes for <linux/ip.h>.

All these kernel headers need cleanup, and I don't know enough to fix it.

Jeff.

