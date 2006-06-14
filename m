Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWFNAzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWFNAzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWFNAzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:55:07 -0400
Received: from relay01.pair.com ([209.68.5.15]:7440 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932388AbWFNAzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:55:06 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 04/11] Task watchers:  Make process events configurable as a module
Date: Tue, 13 Jun 2006 19:54:42 -0500
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060613235122.130021000@localhost.localdomain> <1150242882.21787.144.camel@stark>
In-Reply-To: <1150242882.21787.144.camel@stark>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131955.04554.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 18:54, Matt Helsley wrote:

> +static void cn_proc_fini(void)
> +{
> +	int err;
> +
> +	err = unregister_task_watcher(&cn_proc_nb);
> +	if (err != 0)
> +		printk(KERN_WARNING
> +		       "cn_proc failed to unregister its task notify block\n");

How about if (err), or if (unregister_task_watcher(&cn_proc_nb))?

> +	cn_del_callback(&cn_proc_event_id);
> +}
> +
>  module_init(cn_proc_init);
> +module_exit(cn_proc_fini);

Thanks,
Chase
