Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbUK2Tk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUK2Tk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbUK2TiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:38:25 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:34838 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261721AbUK2Tc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:32:26 -0500
Date: Mon, 29 Nov 2004 20:32:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM 1/10: Base CKRM Events
Message-ID: <20041129193226.GA8397@mars.ravnborg.org>
Mail-Followup-To: Gerrit Huizenga <gh@us.ibm.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
	ckrm-tech <ckrm-tech@lists.sourceforge.net>
References: <E1CYqXA-00056l-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqXA-00056l-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Index: linux-2.6.10-rc2/kernel/ckrm/Makefile
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.10-rc2/kernel/ckrm/Makefile	2004-11-19 20:40:52.528302080 -0800
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for CKRM
> +#
> +
> +ifeq ($(CONFIG_CKRM),y)
> +    obj-y = ckrm_events.o
> +endif	

Plase make this:

obj-y := ckrm_events.o

> --- linux-2.6.10-rc2.orig/kernel/Makefile	2004-11-14 17:27:09.000000000 -0800
> +++ linux-2.6.10-rc2/kernel/Makefile	2004-11-19 20:41:21.885651099 -0800
> @@ -7,7 +7,7 @@
>  	    sysctl.o capability.o ptrace.o timer.o user.o \
>  	    signal.o sys.o kmod.o workqueue.o pid.o \
>  	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
> -	    kthread.o wait.o kfifo.o sys_ni.o
> +	    kthread.o wait.o kfifo.o sys_ni.o ckrm/

And this:
obj-$(CONFIG_CKRM) += ckrm/

	Sam
