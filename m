Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWFZO4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWFZO4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWFZO4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:56:36 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:13249 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932066AbWFZO4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:56:35 -0400
Message-ID: <449FF5A0.2000403@fr.ibm.com>
Date: Mon, 26 Jun 2006 16:56:32 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Savochkin <saw@sw.ru>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru>
In-Reply-To: <20060626134711.A28729@castle.nmd.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> Hi Daniel,

Hi Andrey,

> 
> It's good that you kicked off network namespace discussion.
> Although I wish you'd Cc'ed someone at OpenVZ so I could notice it earlier :).

devel@openvz.org ?

> When a device presents an skb to the protocol layer, it needs to know to which
> namespace this skb belongs.
> Otherwise you would never get rid of problems with bind: what to do if device
> eth1 is visible in namespace1, namespace2, and root namespace, and each
> namespace has a socket bound to 0.0.0.0:80?

Exact. But, the idea was to retrieve the namespace from the routes.

IMHO, I think there are roughly 2 network isolation implementation:

	- make all network ressources private to the namespace

	- keep a "flat" model where network ressources have a new identifier 
which is the network namespace pointer. The idea is to move only some 
network informations private to the namespace (eg port range, stats, ...)


   Daniel.
