Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUIFVhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUIFVhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUIFVhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:37:42 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:61547 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S266888AbUIFVhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:37:39 -0400
Message-ID: <413CD8BD.7040802@travellingkiwi.com>
Date: Mon, 06 Sep 2004 22:38:05 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
Subject: Re: New proposed DRM interface design
References: <20040904102914.B13149@infradead.org>	 <4139C8A3.6010603@tungstengraphics.com>	 <9e47339104090408362a356799@mail.gmail.com>	 <4139FEB4.3080303@tungstengraphics.com>	 <9e473391040904110354ba2593@mail.gmail.com>	 <1094386050.1081.33.camel@localhost.localdomain>	 <9e47339104090508052850b649@mail.gmail.com>	 <1094398257.1251.25.camel@localhost.localdomain>	 <9e47339104090514122ca3240a@mail.gmail.com>	 <1094417612.1936.5.camel@localhost.localdomain>	 <9e4733910409051511148d74f0@mail.gmail.com>	 <1094425142.2125.2.camel@localhost.localdomain>	 <413CCF79.2080407@travellingkiwi.com> <1094501705.4531.1.camel@localhost.localdomain>
In-Reply-To: <1094501705.4531.1.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2004-09-06 at 21:58, Hamie wrote:
>  
>
>>The fs -> SCSI interface is a logical one.
>>    
>>
>
>We just have to make the fb and DRI to hardware one logical.
>  
>

OK. (Even) I follow that... :)

>  
>
>>Unless you can have fb sitting on top of DRM of course... (I discount 
>>DRM on-top of fb, because of the D == Direct... No other reason :)...
>>
>>Does it make sens to have fb ontop of DRM at all? Anyone?
>>    
>>
>
>In some cases yes. The DRM is happy with the idea of the kernel being a
>DRM client too.
>
>  
>

Alright... So you have drm at the lower level, and the fb sits ontop of 
that... The fb just becomes a user of the DRM... No merge necessary 
then, because all the actual hardware access, memory allocation etc 
would live in drm? Is that right? And all the 2D code would also move 
into the DRM? (IIRC the DRM just has 3D stuff in it yes? IMO It would 
made sense to have all the acceleration & hardware access in the DRM 
together rather than in a separate place... Correct?)

H

