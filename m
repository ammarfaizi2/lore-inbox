Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266359AbTGEPA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbTGEPA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 11:00:26 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:42453 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S266359AbTGEPAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 11:00:24 -0400
Message-ID: <3F06EB64.4090808@Synopsys.COM>
Date: Sat, 05 Jul 2003 17:14:44 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: James Simmons <jsimmons@infradead.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, Flameeyes <daps_mls@libero.it>
Subject: Re: 2.5.71, fbconsole: No boot logo?
References: <Pine.LNX.4.44.0306162133520.12997-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0306162133520.12997-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

James Simmons wrote:
>>It is probably some uninitialized value or something like that.
>>
>>At work I have no logo, while at home I have logo (both 2.5.71 from
>>yesterday), both with matroxfb... Only significant difference I know
>>is that at home I have UP kernel, while at work I have SMP. But it should 
>>not matter, yes?
> 
> 
> Its a bug in cfbimgblt.c. In cfb_imageblit you have a test 
> 
> } else if (image->depth == bpp)
> 
> Its should be 
> 
> } else if (image->depth <= bpp)
> 
> instead. At present the logo will only show up when the framebuffer depth 
> matches the image's depth. cfb_imageblit supports displaying images of 
> equal or lesser depths than the framebuffer.
> 

Would it be possible to include this change in the official
source tree?


Regards

Harri

