Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbUCPHI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 02:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbUCPHI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 02:08:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9926 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263497AbUCPHI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 02:08:56 -0500
Message-ID: <4056A63C.50808@pobox.com>
Date: Tue, 16 Mar 2004 02:01:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
CC: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       prism54-devel@prism54.org, netdev@oss.sgi.com, jgarzik@redhat.com
Subject: Re: [Prism54-devel] Re: Prism54 in 2.6.4-bk2
References: <5.1.0.14.2.20040313180709.00ab4250@pop.t-online.de> <1079199572.7111.0.camel@lapy.tuxslare.org> <20040313203058.GY32439@ruslug.rutgers.edu> <20040313221529.GC32439@ruslug.rutgers.edu> <40569B4B.2020402@pobox.com> <20040316064758.GI24063@ruslug.rutgers.edu>
In-Reply-To: <20040316064758.GI24063@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> On Tue, Mar 16, 2004 at 01:14:35AM -0500, Jeff Garzik wrote:
> 
>>Luis R. Rodriguez wrote:
>>
>>>Regarding WDS on prism54: on the netdev list we discussed this
>>>but no one got back to me as to whether we should really just nuke this
>>>code. Prism54 driver source *does* include WDS support because hey, the
>>>firmware does. Why wouldn't it go in the driver? We haven't given WDS
>>>much though anyway since it's also been low priority on our TODO list.
>>
>>The WDS code was dead code as merged.
>>
>>If you actually use it, I don't mind adding it :)
> 
> 
> I don't know of anybody who uses it. We did consider to drop it but we
> just never got around to deciding what we were going to do about it. I
> know it's there and it's *supposed* to work. 
> 
> Can we get back to you on that?  :)  It is just code that *is*
> driver/hardware specific.

For code is that (a) experimental, (b) for pre-production hardware, or 
(c) rarely if ever used, we would prefer to not merge it at all.

When I see stuff like "TODO: actually give this some thought" and "I 
don't know anybody who uses it", that means it doesn't need to be merged 
in the upstream tree :)


> Actually can I just send you a patch for 2.6 for the latest 2.6 tree to
> match ours? That is, rm -rf prism54/ as is and add our latest patch ?
> It'd save a lot of work on our end.

It depends on how big the patch is, and whether or not it adds code that 
nobody but the dev team uses, etc...  I don't want to add the WDS code, 
since nobody uses it...  and adding the #ifdefs I removed would not be 
desired either.  Those #ifdefs aren't need in the upstream tree.  I plan 
to remove them from other upstream drivers, too.

WRT submitting patches...   send away.  drivers/net patches should go -> 
Jean T -> jgarzik+netdev or simply -> jgarzik+netdev, your choice.  In 
general "50 small patches are better than 1 big patch".  Large updates 
are not reviewable or easily testable.  Large patches tend to fix 20 
bugs, and add 5 new ones.

	Jeff



