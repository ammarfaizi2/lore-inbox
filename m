Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275365AbTHGOsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275366AbTHGOsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:48:06 -0400
Received: from dm2-82.slc.aros.net ([66.219.220.82]:40066 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S275365AbTHGOqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:46:50 -0400
Message-ID: <3F326656.9080603@aros.net>
Date: Thu, 07 Aug 2003 08:46:46 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Cc: linux-kernel@vger.kernel.org, Paul Clements <Paul.Clements@SteelEye.com>
Subject: Re: [2.4.21]: nbd ksymoops-report
References: <200308071604.06015.bernd.schubert@pci.uni-heidelberg.de>
In-Reply-To: <200308071604.06015.bernd.schubert@pci.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert wrote:

>Hi,
>
>every time when nbd-client disconnects a nbd-device the decoded oops 
>from below will happen. 
>This only happens after we upgraded from 2.4.20 to 2.4.21, 
>so I guess the backported update from 2.5.50 causes this. 
>Since the changelog for 2.4.22-rc1 doesn't describe any updates to nbd, 
>I think this will be also valid for this kernel version. I will check this 
>later on this evening.
>  
>
>. . .
>  
>
I've seen oops's from nbd disconnect in 2.4 also when some blocks were 
still being flushed (using the standard linux kernel distributed nbd 
driver). I don't know of any back ported fixes to nbd of the ones I've 
been introducing into 2.5+ kernels and have no idea though what could 
have changed between 2.4.20 and 2.4.21 that causes the diff you've seen 
(unless you just never tried the disconnect while blocks still had to be 
flushed before). But a lot of the nbd fixes that have been getting 
introduced into 2.5+ could very well close races and eliminate oops's in 
2.4 also. Getting some more exposure to these fixes in the 2.5+ kernels 
has made a lot of sense since these aren't supposed to be as stable and 
things can be tested more acceptably but at some point back-porting 
starts making sense too. Are we at that point yet?? I don't know. Paul 
Clements is now the NBD maintainer. We should see what he says (I've 
CC'd him on this email).

Stay in touch.

