Return-Path: <linux-kernel-owner+w=401wt.eu-S964921AbXAJP4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbXAJP4o (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 10:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbXAJP4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 10:56:44 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:51430 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbXAJP4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 10:56:43 -0500
Message-ID: <45A50CA5.6070101@in.ibm.com>
Date: Wed, 10 Jan 2007 21:26:21 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       serue@us.ibm.com, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, mbligh@google.com,
       winget@google.com, containers@lists.osdl.org, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 3/6] containers: Add generic multi-subsystem
 API	to containers
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.574346828@menage.corp.google.com>
In-Reply-To: <20061222145216.574346828@menage.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> +/* The set of hierarchies in use. Hierarchy 0 is the "dummy
> + * container", reserved for the subsystems that are otherwise
> + * unattached - it never has more than a single container, and all
> + * tasks are part of that container. */
> +
> +static struct containerfs_root rootnode[CONFIG_MAX_CONTAINER_HIERARCHIES];
> +
> +/* dummytop is a shorthand for the dummy hierarchy's top container */
> +#define dummytop (&rootnode[0].top_container)
> +

With these changes, is there a generic way to determine the root container
for the hierarchy the subsystem is in? Calls to ->create() pass the dummytop
container. It would be useful and is often required to walk the hierarchy
and know the root of the container hierarchy.

-- 
	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
