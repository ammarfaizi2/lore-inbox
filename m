Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVFXPKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVFXPKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVFXPKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:10:50 -0400
Received: from [213.91.247.3] ([213.91.247.3]:20997 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S262955AbVFXPKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:10:46 -0400
Date: Fri, 24 Jun 2005 18:09:40 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@l
To: Neil Horman <nhorman@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Wensong Zhang <wensong@linux-vs.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>
Subject: Re: [Patch] ipvs: close race conditions on ip_vs_conn_tab list
 modification
In-Reply-To: <20050624144822.GD21499@hmsendeavour.rdu.redhat.com>
Message-ID: <Pine.LNX.4.44.0506241808150.2776-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 24 Jun 2005, Neil Horman wrote:

>  			if (ct) {
>  				IP_VS_DBG(4, "del conn template\n");
>  				ip_vs_conn_expire_now(ct);
>  			}

	Don't forget to use cp->control instead of ct, ct is not needed
anymore.

Regards

--
Julian Anastasov <ja@ssi.bg>

