Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423263AbWF1KVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423263AbWF1KVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423262AbWF1KVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:21:02 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26295 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422641AbWF1KVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:21:00 -0400
Message-ID: <44A25802.3030006@fr.ibm.com>
Date: Wed, 28 Jun 2006 12:20:50 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk
Subject: Re: [RFC] Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru> <m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Eric W. Biederman wrote:
> Thinking about this I am going to suggest a slightly different direction
> for get a patchset we can merge.
> 
> First we concentrate on the fundamentals.
> - How we mark a device as belonging to a specific network namespace.
> - How we mark a socket as belonging to a specific network namespace.
> 
> As part of the fundamentals we add a patch to the generic socket code
> that by default will disable it for protocol families that do not indicate
> support for handling network namespaces, on a non-default network namespace.
> 
> I think that gives us a path that will allow us to convert the network stack
> one protocol family at a time instead of in one big lump.
> 
> Stubbing off the sysfs and sysctl interfaces in the first round for the
> non-default namespaces as you have done should be good enough.
> 
> The reason for the suggestion is that most of the work for the protocol
> stacks ipv4 ipv6 af_packet af_unix is largely noise, and simple
> replacement without real design work happening.  Mostly it is just
> tweaking the code to remove global variables, and doing a couple
> lookups.

How that proposal differs from the initial Daniel's patchset ? how far was
that patchset to reach a similar agreement ?

OK, i wear blue socks :), but I'm not advocating a patchset more than
another i'm just looking for a shorter path.

thanks,

C.

