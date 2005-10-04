Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVJDPeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVJDPeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJDPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:34:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52634 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964809AbVJDPeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:34:22 -0400
Date: Tue, 4 Oct 2005 10:34:14 -0500
From: serue@us.ibm.com
To: Erik Jacobson <erikj@sgi.com>
Cc: pagg@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Process Notification / pnotify user: Job
Message-ID: <20051004153414.GA9154@sergelap.austin.ibm.com>
References: <20051003184644.GA19106@sgi.com> <20051003185155.GB19106@sgi.com> <20051003190219.GA20154@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003190219.GA20154@sgi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Erik Jacobson (erikj@sgi.com):
> Index: linux/init/Kconfig
> ===================================================================
> --- linux.orig/init/Kconfig	2005-09-30 12:14:10.989916853 -0500
> +++ linux/init/Kconfig	2005-09-30 13:59:19.749826026 -0500
> @@ -170,6 +170,35 @@
>       Linux Jobs module and the Linux Array Sessions module.  If you will not
>       be using such modules, say N.
>  
> +config JOB
> +	tristate "  Process Notification (pnotify) based jobs"

Should it be possible to compile job as a module, or should
this not be "tristate"?

It makes use of send_group_sig_info, which is not EXPORTed.

thanks,
-serge
