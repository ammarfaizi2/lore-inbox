Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWENHGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWENHGm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWENHGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:06:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:48695 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751357AbWENHGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:06:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=t9DXhpuh6UU/tXUY7zfKV4dpAGy7Ch0xrAqbOmYevXefvwK2+4l/aFsTL9cDOVts85+hAhIBRaUsETvg8wNx2v3JSPCKG3eoObLUieb8ybG6+5aji0Z62pgg7FZ39G9eBd1Qp3FJ86RQY42Y86rp6w1T9V88lITSOdci4+huibA=
Message-ID: <4466D6FB.1040603@gmail.com>
Date: Sun, 14 May 2006 16:06:35 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Jan Wagner <jwagner@kurp.hut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi>
In-Reply-To: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Wagner wrote:
> Hi,
> 
> anyone know if the now already somewhat old Streaming Feature Set of
> ATA/ATAPI 7 is going to be implemented in the kernel ata functions?
> 
> According to one web site that contains hdreg.h
> http://www.koders.com/c/fidCD7293464D782E48F93EEF8A71192F1BF28FC205.aspx
> there's at least some kind of mention in that include file about streaming
> feature set, kernel 2.6.10. However in 2.6.16 it seems to be gone again.
> Any ideas if this will be implemented, or how to use it with e.g. hdparm
> right now?
> 

I don't think streaming feature set is something to be supported at 
kernel driver level.  The usage model doesn't fit with block interface. 
  If you want to use it, the best way would be issuing commands directly 
using sg.  What are you gonna use it for?

-- 
tejun
