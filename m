Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTKTBuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTKTBuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:50:39 -0500
Received: from relay-5v.club-internet.fr ([194.158.96.110]:60109 "EHLO
	relay-5v.club-internet.fr") by vger.kernel.org with ESMTP
	id S264233AbTKTBuh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:50:37 -0500
From: pinotj@club-internet.fr
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Thu, 20 Nov 2003 02:50:35 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069293035.2246.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Date: Wed, 19 Nov 2003 17:07:53 -0800
>De: Andrew Morton <akpm@osdl.org>
>A: pinotj@club-internet.fr
>Copie à: linux-kernel@vger.kernel.org
>Sujet: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
>
>pinotj@club-internet.fr wrote:
>>
>> kernel BUG at mm/slab.c:1957!
[...]
>
>urgh, there are several reports of this and it's always the buffer_head
>slab.  The code in there is trivial so perhaps it's just that the large
>number of buffer_heads makes them a fat target.
>
>You should have also seen the message "slab: double free detected in cache
>'buffer_head', objp 0xNNNNNNNN".

Yeah, you right, I forgot to mention it, it was just above the Oops in the logs:
---
slab: double free detected in cache 'buffer_head', objp cd09af18.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1957!
---

>Don't know, sorry.

Is there any thing I can do to help figure out where does the problem comes from ? Anyway, thanks for your answer.

Regards,

Jerome Pinot

