Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130409AbRCBLHz>; Fri, 2 Mar 2001 06:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130410AbRCBLHq>; Fri, 2 Mar 2001 06:07:46 -0500
Received: from jalon.able.es ([212.97.163.2]:5255 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130409AbRCBLHZ>;
	Fri, 2 Mar 2001 06:07:25 -0500
Date: Fri, 2 Mar 2001 12:07:12 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: [OT] style-curiosity
Message-ID: <20010302120712.C4416@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0103021010570.1338-100000@penguin.homenet> <Pine.LNX.4.21.0103021053290.1338-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0103021053290.1338-100000@penguin.homenet>; from tigran@veritas.com on Fri, Mar 02, 2001 at 11:55:39 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.02 Tigran Aivazian wrote:
> +	c = misc_list.next;
> +	while (c != &misc_list) {
> +		if (c->minor == misc->minor) {
> +			up(&misc_sem);
> +			return -EBUSY;
> +		}
>  		c = c->next;
> -	if (c == &misc_list) {
> -		up(&misc_sem);
> -		return -EBUSY;
>  	}

Just a matter of style and curiosity.

Would you kernel programmers consider this 'bad C' (I usually see this
much more clear...)

for (c = misc_list.next; c != &misc_list; c = c->next)
{
	if (c->minor == misc->minor) {
		up(&misc_sem);
		return -EBUSY;
	}	
}

Has any effect on output assembly ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac7 #1 SMP Fri Mar 2 02:36:23 CET 2001 i686

