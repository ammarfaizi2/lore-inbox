Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUGXUWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUGXUWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 16:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUGXUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 16:22:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51136 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262605AbUGXUWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 16:22:54 -0400
Date: Sat, 24 Jul 2004 16:21:50 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: Robert Love <rml@ximian.com>
cc: Andrew Morton <akpm@osdl.org>, kaos@ocs.com.au, da-x@gmx.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
In-Reply-To: <1090648973.2296.68.camel@localhost>
Message-ID: <Pine.LNX.4.58.0407241615590.29625@devserv.devel.redhat.com>
References: <4956.1090644161@ocs3.ocs.com.au>  <1090645238.2296.37.camel@localhost>
  <20040724011129.54971669.akpm@osdl.org>  <1090647444.2296.54.camel@localhost>
 <1090648973.2296.68.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2004, Robert Love wrote:

> +static int kevent_init(void)
> +{
> +	kevent_sock = netlink_kernel_create(NETLINK_KEVENT, netlink_receive);

Consider a NULL netlink_receive function, as you're dropping any received
messages.  This will provide better interface semantics e.g.  connection
refused message on message transmission to kernel.


- James
-- 
James Morris
<jmorris@redhat.com>

