Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVHaGnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVHaGnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 02:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVHaGnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 02:43:05 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:29849 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932400AbVHaGnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 02:43:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Qx8BWOMRCFjE9gWhEBdWvIzkTac793W7+ypu2OwSkiX2YwJdyrErbNme00tSCJGsHjffUXBSv1zmjI039hPbUTT+TjOV9+eD5VMGkPDnTX2535Rfu6fjujbrytCnw+jRImnPbwd/9SBfcm+eGNq8u+n7xSsThuExGwn9fWwsTVk=
Message-ID: <4315515C.1040208@gmail.com>
Date: Wed, 31 Aug 2005 14:42:36 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Knut Petersen <Knut_Petersen@t-online.de>,
       linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508310159290.3728@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Wed, 31 Aug 2005, Knut Petersen wrote:
> 
>> How could I make it an inline function? It is used in console/bitblit.c,
>> nvidia/nvidia.c,
>> riva/fbdev.c and softcursor.c.
> 
> Something like below, which has the advantange that there is still only 
> one implementation of the function and if it's still slower, we really 
> need to check the compiler.
> 

I do get better numbers with this, not much, but better than Knut's (5ms), and
definitely much better than the old uninlined one (100ms).

Andrew, don't get this yet.  I'll incorporate this with the bit_putcs()
breakup that I'm currently doing.

Roman, okay if you have a 'Signed-off-by' line?

Tony
