Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVHHVhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVHHVhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVHHVhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:37:33 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:12160 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932268AbVHHVhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:37:32 -0400
Message-ID: <42F7D08E.9070508@colorfullife.com>
Date: Mon, 08 Aug 2005 23:37:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [SLAB] __builtin_return_address use without FRAME_POINTER causes
 boot failure
References: <Pine.LNX.4.62.0508081353170.28612@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0508081353170.28612@graphe.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>I kept getting boot failures in the slab allocator. The failure goes 
>away if one is setting CONFIG_FRAME_POINTER. Seems that 
>CONFIG_DEBUG_SLAB implies the use of __buildin_return_address() which 
>needs the framepointer.
>
>  
>
Very odd. __builtin_return_address(1) needs frame pointers, but slab 
only uses __builtin_return_addresse(0), which should always work.

--
    Manfred
