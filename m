Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTIQGle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 02:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTIQGle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 02:41:34 -0400
Received: from users.linvision.com ([62.58.92.114]:11655 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262681AbTIQGld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 02:41:33 -0400
Date: Wed, 17 Sep 2003 08:41:03 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030917084102.A19276@bitwizard.nl>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 03:36:14PM +0100, Alan Cox wrote:
> I/O is a real pain. Also in some cases it might be interesting to try
> using the extra RAM above the 4G boundary as a giant ram disk and using
> it as first swap device.

4G? Above 4G? The limit should be configurable a lot earlier. 

I'd want to configure that on the machines I'm installing tomorrow. 
4G RAM, but I'd rather not use the highmem stuff. I think the workload
that this machine is likely to get will work very well with this setup. 

Why does this have the opportunity to work better than just using the 
2 or 4G of RAM? Because after you've used the bottom 1G, that might 
just remain there, requiring lots of IO to go through bounce buffers
and memory remappings. By considering the top part of RAM as swap,
you'll force the important stuff into the more easily accessable
RAM (Compare to fastram as it was called on the Amiga!). 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
