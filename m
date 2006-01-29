Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWA2TFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWA2TFi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWA2TFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:05:38 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64648
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751114AbWA2TFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:05:38 -0500
Date: Sun, 29 Jan 2006 11:05:39 -0800
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
Message-ID: <20060129190539.GA26794@kroah.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lkwza479.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 12:22:34AM -0700, Eric W. Biederman wrote:
> +struct task_ref
> +{
> +	atomic_t count;

Please use a struct kref here, instead of your own atomic_t, as that's
why it is in the kernel :)

> +	enum pid_type type;
> +	struct task_struct *task;
> +};

thanks,

greg k-h
