Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVA0AZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVA0AZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVA0AYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:24:31 -0500
Received: from quark.didntduck.org ([69.55.226.66]:49802 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262512AbVAZXbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:31:23 -0500
Message-ID: <41F82844.7020504@didntduck.org>
Date: Wed, 26 Jan 2005 18:31:16 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Wed, 26 Jan 2005, Rik van Riel wrote:
> 
>> With some programs the 2.6 kernel can end up allocating memory
>> at address zero, for a non-MAP_FIXED mmap call!  This causes
>> problems with some programs and is generally rude to do. This
>> simple patch fixes the problem in my tests.
> 
> 
> Does this mean that we can't mmap the screen regen buffer at
> 0x000b8000 anymore?
> 
> How do I look at the real-mode interrupt table starting at
> offset 0? You know that the return value of mmap is to be
> checked for MAP_FAILED, not for NULL, don't you?

This does not affect the case where the user requests a specific 
virrtual address (ie. vm86 stuff).

--
				Brian Gerst
