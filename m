Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWFJHRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWFJHRH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 03:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWFJHRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 03:17:07 -0400
Received: from main.gmane.org ([80.91.229.2]:19173 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030341AbWFJHRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 03:17:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Subject: Re: [RFC] [patch 0/6] [Network namespace] introduction
Date: 10 Jun 2006 10:16:49 +0300
Message-ID: <5dbqt1v5su.fsf@attruh.keh.iki.fi>
References: <20060609210202.215291000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181108174.pp.htv.fi
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dlezcano@fr.ibm.com writes in gmane.linux.network,gmane.linux.kernel:

> The following patches create a private "network namespace" for use
> within containers. This is intended for use with system containers
> like vserver, but might also be useful for restricting individual
> applications' access to the network stack.
> 
> These patches isolate traffic inside the network namespace. The
> network ressources, the incoming and the outgoing packets are
> identified to be related to a namespace. 
> 
> It hides network resource not contained in the current namespace, but
> still allows administration of the network with normal commands like
> ifconfig.
> 
> It applies to the kernel version 2.6.17-rc6-mm1
> 
> It provides the following:
> -------------------------
>    - when an application unshares its network namespace, it looses its
>      view of all network devices by default. The administrator can
>      choose to make any devices to become visible again. The container
>      then gains a view to the device but without the ip address
>      configured on it. It is up to the container administrator to use
>      ifconfig or ip command to setup a new ip address. This ip address
>      is only visible inside the container.

Do other namespaces work differently ?
When namespace is unshared, it has initially the same resources
(for example compare to CLONE_NEWNS)

 
>    - the loopback is isolated inside the container and it is not
>      possible to communicate between containers via the
>      loopback. 
> 
>    - several containers can have an application bind to the same
>      address:port without conflicting. 

That of course be problem, if initially unshared namespace shares
same resources.

/ Kari Hurtta

