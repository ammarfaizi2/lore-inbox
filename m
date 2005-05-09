Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVEIOHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVEIOHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVEIOHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:07:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42233 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261380AbVEIOH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:07:28 -0400
Date: Mon, 9 May 2005 07:07:21 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Priority Lists for the RT mutex
In-Reply-To: <427C6D7D.878935F1@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0505090706260.6722-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2005, Oleg Nesterov wrote:
> Yes. ->node_list contains *ALL* nodes, that is why we can:
> 
> 	#define	plist_for_each(pos, head)	\
> 		 list_for_each_entry(pos, &(head)->node_list, node_list)
> 
> head <=======>  prio=1 <===> prio=2 <===> ...
>                  /\        /|  /\
>                  |         |   |
>                  \/        |   \/
>                 prio=1     | prio=2
>                  /\       /    /\
>                  |       /     |
>                  \/     /      \/
>                 prio=1 /      ....
>                   <---/
> 
>                                /\
> Where <===> means ->prio_list, |  ->node_list.
>                                \/
> Will do. However, I'm unfamiliar with Ingo's tree, so I
> can send only new plist's implementation.


I've got something like this queued up .. Feel free to send yours as well 
.. 


Daniel

