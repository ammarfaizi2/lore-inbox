Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWHWOG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWHWOG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHWOG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:06:28 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:32471 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932235AbWHWOG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:06:27 -0400
Date: Wed, 23 Aug 2006 10:06:25 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Akinobu Mita <mita@miraclelinux.com>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>, David Miller <davem@davemloft.net>,
       akpm@osdl.org
Subject: Re: call panic if nl_table allocation fails
In-Reply-To: <20060823113740.GA7834@miraclelinux.com>
Message-ID: <Pine.LNX.4.64.0608231003340.3198@d.namei>
References: <20060823113740.GA7834@miraclelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, Akinobu Mita wrote:

> This patch makes crash happen if initialization of nl_table fails
> in initcalls. It is better than getting use after free crash later.

>  	nl_table = kcalloc(MAX_LINKS, sizeof(*nl_table), GFP_KERNEL);

Perhaps it'd be better to declare this as an array rather than allocating 
it at runtime.



- James
-- 
James Morris
<jmorris@namei.org>
