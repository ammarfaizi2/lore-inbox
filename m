Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUIFVrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUIFVrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUIFVrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:47:40 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:32299 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267350AbUIFVri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:47:38 -0400
Message-ID: <9e473391040906144733e474a7@mail.gmail.com>
Date: Mon, 6 Sep 2004 17:47:37 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Hamie <hamish@travellingkiwi.com>
Subject: Re: New proposed DRM interface design
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <413CD8BD.7040802@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094398257.1251.25.camel@localhost.localdomain>
	 <9e47339104090514122ca3240a@mail.gmail.com>
	 <1094417612.1936.5.camel@localhost.localdomain>
	 <9e4733910409051511148d74f0@mail.gmail.com>
	 <1094425142.2125.2.camel@localhost.localdomain>
	 <413CCF79.2080407@travellingkiwi.com>
	 <1094501705.4531.1.camel@localhost.localdomain>
	 <413CD8BD.7040802@travellingkiwi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some examples of merging are turning two independent radeon
personality modules into a single one. Another thing I need to do is
to extract the printk support from the core fb module and put it
somewhere I can get to it from DRM. We can't have two cores trying to
attach to the same device and then doing takeover_console().

Mode setting will be a lot of new code since Alan's proposed design
doesn't match any of the existing solutions. I will try to reuse
snippets where I can.


On Mon, 06 Sep 2004 22:38:05 +0100, Hamie <hamish@travellingkiwi.com> wrote:
> Alright... So you have drm at the lower level, and the fb sits ontop of
> that... The fb just becomes a user of the DRM... No merge necessary
> then, because all the actual hardware access, memory allocation etc
> would live in drm? Is that right? And all the 2D code would also move
> into the DRM? (IIRC the DRM just has 3D stuff in it yes? IMO It would
> made sense to have all the acceleration & hardware access in the DRM
> together rather than in a separate place... Correct?)
> 

-- 
Jon Smirl
jonsmirl@gmail.com
