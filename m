Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVFZVZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFZVZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 17:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFZVZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 17:25:57 -0400
Received: from [141.211.252.161] ([141.211.252.161]:38535 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261597AbVFZVYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 17:24:36 -0400
Date: Sun, 26 Jun 2005 23:24:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>
Subject: Re: [patch 08/38] CKRM e18: Documentation
Message-ID: <20050626212426.GB1315@elf.ucw.cz>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061755.719424000@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623061755.719424000@w-gerrit.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds all current documentation on CKRM.
> 
> Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
> Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
> Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
> Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
> Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
> 
>  TODO         |   16 +++++++++
>  ckrm_basics  |   66 +++++++++++++++++++++++++++++++++++++++
>  core_usage   |   72 +++++++++++++++++++++++++++++++++++++++++++
>  crbce        |   33 +++++++++++++++++++
>  installation |   70 ++++++++++++++++++++++++++++++++++++++++++
>  rbce_basics  |   67 ++++++++++++++++++++++++++++++++++++++++
>  rbce_usage   |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 422 insertions(+)
> 
> Index: linux-2.6.12-ckrm1/Documentation/ckrm/ckrm_basics
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.12-ckrm1/Documentation/ckrm/ckrm_basics	2005-06-20 13:08:35.000000000 -0700
> @@ -0,0 +1,66 @@
> +CKRM Basics
> +-------------

Perhaps you want to explain what "CKRM" means?

> +RCFS depicts a CKRM class as a directory. Hierarchy of classes can be

Another four letter acronym, unexplained?

> +   # cat /rcfs/taskclass/c1/members
> +   lists pids of tasks belonging to c1
> +
> +   # cat /rcfs/socket_class/s1/members
> +   lists the ipaddress\port of all listening sockets in s1
                         ~
			  did you want to use "/" here?

> Index: linux-2.6.12-ckrm1/Documentation/ckrm/crbce
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.12-ckrm1/Documentation/ckrm/crbce	2005-06-20 13:08:35.000000000 -0700
> @@ -0,0 +1,33 @@
> +CRBCE
> +----------
> +
> +crbce is a superset of rbce. In addition to providing automatic
> +classification, the crbce module

Nice, but you should describe what RBCE means... And capitalize your
acronyms consistently...

> Index: linux-2.6.12-ckrm1/Documentation/ckrm/rbce_basics
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.12-ckrm1/Documentation/ckrm/rbce_basics	2005-06-20 13:08:35.000000000 -0700
> @@ -0,0 +1,67 @@
> +Rule-based Classification Engine (RBCE)
> +-------------------------------------------
> +
> +The ckrm/rbce directory contains the sources for two classification engines
> +called rbce and crbce. Both are optional, built as kernel modules and share much
> +of their codebase. Only one classification engine (CE) can be loaded at a time
> +in CKRM.

TMFLAs! (*)

Your resource managment may be quite nice system, but the naming is
definitely very ugly. With your design we would not have open() system
call, but ofsoarh() -- open filesystem object and return its
handle. Can you come up with some reasonable naming?

								Pavel
(*) Too many four letter acronyms.
-- 
teflon -- maybe it is a trademark, but it should not be.
