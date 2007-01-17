Return-Path: <linux-kernel-owner+w=401wt.eu-S1751728AbXAQHyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbXAQHyG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 02:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXAQHyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 02:54:06 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42759 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728AbXAQHyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 02:54:05 -0500
Message-Id: <1169020441.11252.1169664809@webmail.messagingengine.com>
X-Sasl-Enc: cKHL9v7Ak2FIBvtUH6iWwMEIqmD5Qql0Wb4YRIjxweU0 1169020441
From: "Clemens Ladisch" <clemens@ladisch.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
   <11689656683585-git-send-email-ebiederm@xmission.com>
Subject: Re: [PATCH 42/59] sysctl: Remove sys_sysctl support from the hpet timer
   driver.
In-Reply-To: <11689656683585-git-send-email-ebiederm@xmission.com>
Date: Wed, 17 Jan 2007 08:54:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> In the binary sysctl interface the hpet driver was claiming to
> be the cdrom driver.  This is a no-no so remove support for the
> binary interface.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  drivers/char/hpet.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 20dc3be..81be1db 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -703,7 +703,7 @@ int hpet_control(struct hpet_task *tp, unsigned int
> cmd, unsigned long arg)
>  
>  static ctl_table hpet_table[] = {
>  	{
> -        .ctl_name = 1,
> +        .ctl_name = CTL_UNNUMBERED,
>  	 .procname = "max-user-freq",
>  	 .data = &hpet_max_freq,
>  	 .maxlen = sizeof(int),
> @@ -715,7 +715,7 @@ static ctl_table hpet_table[] = {
>  
>  static ctl_table hpet_root[] = {
>  	{
> -        .ctl_name = 1,
> +        .ctl_name = CTL_UNNUMBERED,
>  	 .procname = "hpet",
>  	 .maxlen = 0,
>  	 .mode = 0555,
> -- 
> 1.4.4.1.g278f
