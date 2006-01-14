Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWANQVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWANQVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWANQVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:21:45 -0500
Received: from plesk3.eurovps.com ([83.149.123.5]:38076 "EHLO
	plesk3.eurovps.com") by vger.kernel.org with ESMTP id S1751775AbWANQVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:21:44 -0500
Message-ID: <43C92502.30307@cube.gr>
Date: Sat, 14 Jan 2006 18:21:22 +0200
From: Faidon Liambotis <faidon@cube.gr>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
References: <20060114160253.GA1073@elte.hu>
In-Reply-To: <20060114160253.GA1073@elte.hu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> @@ -1371,11 +1373,11 @@ static ssize_t psmouse_attr_set_protocol
>  			return -EIO;
>  		}
>  
> -		up(&psmouse_sem);
> +		mutex_unlock(&psmouse_mutex);
>  		serio_unpin_driver(serio);
>  		serio_unregister_child_port(serio);
>  		serio_pin_driver_uninterruptible(serio);
> -		down(&psmouse_sem);
> +		mutex_lock(&psmouse_mutex);
Isn't that supposed to be the other way around?

Regards,
Faidon
