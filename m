Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUEBS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUEBS1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUEBS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 14:27:52 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:29738 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263191AbUEBS1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 14:27:51 -0400
Date: Sun, 2 May 2004 20:31:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: always store MODULE_VERSION("") data?
Message-ID: <20040502183158.GA2136@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Matt Domsch <Matt_Domsch@dell.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040427145812.GA20421@lists.us.dell.com> <1083200122.9669.16.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083200122.9669.16.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 10:55:22AM +1000, Rusty Russell wrote:
>  
> +config MODULE_SRCVERSION_ALL
> +	bool "Source checksum for all modules"
> +	depends on MODULES
> +	help
> +	  Modules which contain a MODULE_VERSION get an extra "srcversion"
> +	  field inserting into their modinfo section, which contains a
> +    	  sum of the source files which made it.  This helps maintainers
> +	  see exactly which source was used to build a module (since
> +	  others sometimes change the module source without updating
> +	  the version).  With this option, such a "srcversion" field
> +	  will be created for all modules.  If unsure, say N.

I had to read the above twice to get the fact that it was added to all modules regardless.
Move the second last sentence first, so the explanation comes after?
Any reason not to enable it pr. default, at least to give it some exposure?

>  void
> +add_srcversion(struct buffer *b, struct module *mod)
> +{
> +	if (mod->srcversion[0]) {

Why not checking the flag?

	Sam
