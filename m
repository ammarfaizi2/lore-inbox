Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVG2H3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVG2H3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVG2H3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:29:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28820 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262460AbVG2H3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:29:30 -0400
Date: Fri, 29 Jul 2005 09:29:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: dtor_core@ameritech.net
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space (updated)
In-Reply-To: <d120d50005072809407a179d7e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507290851030.26861@yvahk01.tjqt.qr>
References: <20050728145353.GL11644@mellanox.co.il> <d120d50005072809407a179d7e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 9. The following is helpful with VIM
>>        set cinoptions=(0:0
>> 
>
>And this will highlight whitespace damage:
>
>highlight RedundantSpaces ctermbg=red guibg=red 
>match RedundantSpaces /\s\+$\| \+\ze\t/

find linux -type f -print0 | xargs -0 egrep '[[:space:]]+$'

With `wc -l`, returns 132409* (wow, that's a lot of violations). Too bad that 
(e)grep does not support \s for space.


* Number might vary.

Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
