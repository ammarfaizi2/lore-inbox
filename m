Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTLaMnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLaMnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:43:32 -0500
Received: from 195-23-16-24.nr.ip.pt ([195.23.16.24]:40320 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264450AbTLaMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:43:31 -0500
Message-ID: <3FF2C45D.6090004@grupopie.com>
Date: Wed, 31 Dec 2003 12:43:09 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
References: <20031231002942.GB2875@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Oh yeah, and there are the insolvable race conditions with the devfs
> implementation in the kernel, but I'm not going to talk about them right
> now, sorry.  See the linux-kernel archives if you care about them (and
> if you use devfs, you should care...)

I really think you should, because IMHO this is *the* major argument against devfs.

I spent days trying to tweak a mandrake distribution into running from a Compact 
Flash card.

The init sequence would fail with I/O errors as if the card had hardware 
problems. It took me a long time to realize that it was devfs and devfsd the 
culprits. With *exactly* the same setup, but static device nodes the system 
worked just fine.

Maybe it was the slow compact flash PIO modes that were triggering the bug, but 
the truth was that devfs had bugs in it, and I never saw anyone trying to 
correct them later.

So my opinion is: udev is *really* needed and you're doing a great job with it. 
Don't let anyone tell you otherwise :)

Just my 2 cents,

-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

