Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVBWNP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVBWNP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 08:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVBWNP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 08:15:26 -0500
Received: from [195.23.16.24] ([195.23.16.24]:15829 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261485AbVBWNPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 08:15:21 -0500
Message-ID: <421C8193.2050808@grupopie.com>
Date: Wed, 23 Feb 2005 13:13:55 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
References: <200502211216.35194.gene.heskett@verizon.net> <200502211325.55013.gene.heskett@verizon.net> <20050221182952.GF6722@wiggy.net> <200502211708.27211.gene.heskett@verizon.net> <20050222231000.GA3163@waste.org>
In-Reply-To: <20050222231000.GA3163@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
>[...]
> JPEG data is DCT of 8x8 pixel chunks. If you can get at that, you can
> compare the DC terms of each chunk with minimal decoding. Various
> thumbnailers do this for speed already.

I really doubt that this would work. It seems to me that you can have 
very different DC terms with very similar results. In other words, even 
a little noise in the picture might produce very different DC terms.

Instead of comparing the DC terms, you could compare just the luminance. 
You would have to decompress just half the data for that and you 
wouldn't need to make the YUV->RGB conversion. That would probably save 
a few cycles.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
