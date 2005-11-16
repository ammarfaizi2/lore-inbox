Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVKPJsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVKPJsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVKPJsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:48:21 -0500
Received: from barclay.balt.net ([195.14.162.78]:24473 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S932593AbVKPJsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:48:20 -0500
Date: Wed, 16 Nov 2005 11:45:52 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Zhu Yi <yi.zhu@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051116094551.GA23140@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com> <20051115140023.GB9910@gemtek.lt> <1132120145.18679.12.camel@debian.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132120145.18679.12.camel@debian.sh.intel.com>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please see : http://www.gemtek.lt/~zilvinas/dumps/trace 

This time I didn't see oops printed again :( Don't understand why,
although I have managed to capture SysRQ-T output - see URL above.
Kernel has been updated this morning to revision:

f6ff56cd56b83d8edf4b3cffc5c53c56b37a5081 

plus additionally applied patch from URL. Interesting this time I
haven't seen any signs of slab corruptions or any such things :(

I hope this helps. Any other ideas and things to try out ? :)

btw, what are these messages about:
 Unknown notification: subtype=40,flags=0xa0,size=40

I've read a ipw2200.c code and didn't see what is subtype=40 ...
Because once those messages are starting showing up - immediately (most
of the time) follows by kernel freeze (sysrq is working though ...). 

Zilvinas

On Wed, Nov 16, 2005 at 01:49:04PM +0800, Zhu Yi wrote:
> On Tue, 2005-11-15 at 16:00 +0200, Zilvinas Valinskas wrote:
> > Hello again,
> > 
> > screenshots of ooops (not of the best quality though :( ) - 
> > http://www.gemtek.lt/~zilvinas/dumps/  - as it can be seen from
> > screenshots crashing in _ipw_read_indirect_0xa9/0x179 ... This time it
> > took a while to reproduce a problem. Somehow I get impression it is
> > either f/w loading related (see attached oops.1 file) and/or initiating
> > scan and reading back wireless scan results ??? ...
> 
> Please try the patch below and see if it makes any difference.
> http://bughost.org/bugzilla/show_bug.cgi?id=821
> 
> Thanks,
> -yi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
