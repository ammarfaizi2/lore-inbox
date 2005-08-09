Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVHIRFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVHIRFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVHIRFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:05:34 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:47232 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S964886AbVHIRFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:05:33 -0400
Message-ID: <42F8E243.2060505@colorfullife.com>
Date: Tue, 09 Aug 2005 19:05:07 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: Christoph Lameter <christoph@lameter.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [SLAB] __builtin_return_address use without FRAME_POINTER causes
 boot failure
References: <Pine.LNX.4.62.0508081353170.28612@graphe.net> <42F7D08E.9070508@colorfullife.com> <20050808215353.GA26384@localhost.localdomain>
In-Reply-To: <20050808215353.GA26384@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:

>My fault, I introduced a debugging patch (i think i cc'ed you on it)
>which used __builtin_return_address([12]) to save traces of who the
>caller of an object is.
>  
>
Ups. I still have your original mail in my inbox.
The correct way is check the whole stack and store all pointers that are 
in kernel_text_address(). See store_stack_info() in mm/slab.c.

--
    Manfred
