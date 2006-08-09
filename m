Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWHIRsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWHIRsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWHIRsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:48:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751273AbWHIRsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:48:23 -0400
Date: Wed, 9 Aug 2006 10:47:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-ID: <20060809104738.1498723f@localhost.localdomain>
In-Reply-To: <11551105602734@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru>
	<11551105602734@2ka.mipt.ru>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 12:02:40 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> 
> Core files.
> 
> This patch includes core kevent files:
>  - userspace controlling
>  - kernelspace interfaces
>  - initialization
>  - notification state machines
> 
> It might also inlclude parts from other subsystem (like network related
> syscalls, so it is possible that it will not compile without other
> patches applied).
> 
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> 
> 
> +#ifdef CONFIG_KEVENT_USER_STAT
> +static inline void kevent_user_stat_init(struct kevent_user *u)
> +{
> +	u->wait_num = u->im_num = u->total = 0;
> +}
> +static inline void kevent_user_stat_print(struct kevent_user *u)
> +{
> +	pr_debug("%s: u=%p, wait=%lu, immediately=%lu, total=%lu.\n", 
> +			__func__, u, u->wait_num, u->im_num, u->total);
> +}
> +static inline void kevent_user_stat_increase_im(struct kevent_user *u)
> +{
> +	u->im_num++;
> +}
> +static inline void kevent_user_stat_increase_wait(struct kevent_user *u)
> +{
> +	u->wait_num++;
> +}
> +static inline void kevent_user_stat_increase_total(struct kevent_user *u)
> +{
> +	u->total++;
> +}
>

static wrapper_functions_with_execessive_long_names(struct i_really_hate *this)
{
	suck();
}
