Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965384AbWHOSiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbWHOSiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWHOSiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:38:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23012 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965384AbWHOSiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:38:05 -0400
Subject: Re: [PATCH 5/7] pid: Implement pid_nr
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <1155666193751-git-send-email-ebiederm@xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	 <1155666193751-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 11:37:43 -0700
Message-Id: <1155667063.12700.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 12:23 -0600, Eric W. Biederman wrote:
> +static inline pid_t pid_nr(struct pid *pid)
> +{
> +       pid_t nr = 0;
> +       if (pid)
> +               nr = pid->nr;
> +       return nr;
> +} 

When is it valid to be passing around a NULL 'struct pid *'?

-- Dave

