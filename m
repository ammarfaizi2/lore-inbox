Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWBAMhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWBAMhl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBAMhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:37:40 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:34444 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932457AbWBAMh3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:37:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XpuVClRVV3jdDdy68mSq/yS6b/nuTPIVmPe0PQzl7HDeSKS5qSeED0eP4ywebEWuOOSQjKjR/5o9V8Y75IrQMIAvdQuIONeGjdnpP2LkFWe2k2iSkTDTbUdrprUmdK9q/pxvfshTko4UwaKa0i/YXW3IdguY+jl6nebW0zB+gkU=
Message-ID: <84144f020602010437n1d738b94m2d08ddfb21fdb300@mail.gmail.com>
Date: Wed, 1 Feb 2006 14:37:27 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 02/10] [Suspend2] Module (de)registration.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060201113713.6320.99223.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060201113713.6320.99223.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> +++ b/kernel/power/modules.c
> @@ -0,0 +1,87 @@

[snip]

> +
> +struct list_head suspend_filters, suspend_writers, suspend_modules;
> +struct suspend_module_ops *active_writer = NULL;
> +static int num_filters = 0, num_ui = 0;
> +int num_writers = 0, num_modules = 0;

Unneeded assignments, they're already guaranteed to be zeroed.

> +       list_add_tail(&module->module_list, &suspend_modules);
> +       num_modules++;

No locking, why?

                                 Pekka
