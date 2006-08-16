Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWHPPMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWHPPMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHPPMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:12:13 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:47502 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751194AbWHPPMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:12:12 -0400
Date: Wed, 16 Aug 2006 23:35:57 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 6/7] vt: Update spawnpid to be a struct pid_t
Message-ID: <20060816193557.GA586@oleg>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> <1155666193191-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155666193191-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Eric W. Biederman wrote:
>
> diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
> index 28eff1a..d7e0187 100644
> --- a/drivers/char/vt_ioctl.c
> +++ b/drivers/char/vt_ioctl.c
> @@ -645,12 +645,13 @@ #endif
>  	 */
>  	case KDSIGACCEPT:
>  	{
> -		extern int spawnpid, spawnsig;
> +		struct pid *spawnpid;
		^^^^^^^^^^^^^^^^^^^^
Should be "extern struct pid *spawnpid" ?

Oleg.

