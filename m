Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUCGGJG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 01:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUCGGJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 01:09:06 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:35272 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261760AbUCGGJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 01:09:01 -0500
Message-ID: <404ABC74.7030607@matchmail.com>
Date: Sat, 06 Mar 2004 22:08:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: "Ramy M. Hassan" <ramy@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: Advanced storage management ( suggestion )
References: <003801c402ea$44437190$ba10a8c0@ramy>	<404A9835.4020602@matchmail.com> <16458.42370.917655.953328@notabene.cse.unsw.edu.au>
In-Reply-To: <16458.42370.917655.953328@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Saturday March 6, mfedyk@matchmail.com wrote:
> 
>>>2- Support for multi-disk/multi-host storage pool.
>>
>>You're mixing layers here.  MD and DM already work in this area.
>>
> 
> 
> I would probably disagree here.
> I think it makes much more sense for a filesystem to know about
> multiple devices than for MD or DM to combine a bunch of devices into
> the illusion of one big device, only to have the filesystem chop that
> big device into little files....
> 
> (Note that I wouldn't expect a filesystem to include raid5 style
> behaviour, and probably wouldn't expect raid1 like behaviour, but
> having the filesystem do striping and inter-device migration itself
> seems eminently sensible.)
> 

I saw something doing that in a SAN.  Don't know if it was at the 
filesytem level though.

> However I don't see much value if the suggestion of a new layer that
> provide lots of services of filesystems.  I strongly suspect that no
> filesystem would want to use them.  Look at "jdb".  It is designed to
> provide a journalling layer for any filesystem, but how many
> filesystems use it?  Just one - ext3 - the one it was designed for.

Since JBD is "Journaled Block Device", does that mean it's meant for 
block based journaling instead of "virtual" (I don't think I'm using the 
right term, so please someone correct me) journaling?

Mike
