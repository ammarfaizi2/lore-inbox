Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUELVB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUELVB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUELVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:00:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17802 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265227AbUELU6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:58:52 -0400
Message-ID: <40A28FFB.3060000@pobox.com>
Date: Wed, 12 May 2004 16:58:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: William Lee Irwin III <wli@holomorphy.com>, mingo@elte.hu,
       davidel@xmailserver.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <20040512020700.6f6aa61f.akpm@osdl.org>	<20040512181903.GG13421@kroah.com>	<40A26FFA.4030701@pobox.com>	<20040512193349.GA14936@elte.hu>	<Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>	<20040512200305.GA16078@elte.hu>	<20040512132050.6eae6905.akpm@osdl.org>	<20040512203829.GI1397@holomorphy.com> <20040512134718.7e55cceb.akpm@osdl.org>
In-Reply-To: <20040512134718.7e55cceb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> @@ -187,7 +187,7 @@ static int act200l_change_speed(struct i
>  		/* Write control bytes */
>  		self->write(self->dev, control, 3);
>  		irda_task_next_state(task, IRDA_TASK_WAIT);
> -		ret = MSECS_TO_JIFFIES(5);
> +		ret = MSEC_TO_JIFFIES(5);


Ewww.

Just pluralize the macro, and this patch gets 75% lighter.

	Jeff



