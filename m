Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269606AbUICKBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269606AbUICKBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269536AbUICJ7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:59:06 -0400
Received: from scrat.hensema.net ([62.212.82.150]:60609 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S269589AbUICJzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:55:00 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: silent semantic changes with reiser4
Date: Fri, 3 Sep 2004 09:54:58 +0000 (UTC)
Message-ID: <slrncjgfri.3mq.erik@bender.home.hensema.net>
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <412D9FFA.6030307@hist.no> <20040902230526.GB15505@zero> <41382624.7000701@hist.no> <1094199553.413829012d745@smartmail.portrix.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer (jdittmer@ppp0.net) wrote:
> Zitat von Helge Hafting <helge.hafting@hist.no>:
>> Tom Vier wrote:
>> 
>> >What's wrong with ~/.thumbcache or a daemon that manages system wide
>> cache?
>> >
>> >  
>> >
>> Moving a file doen't move the associated thumbnail, and then you
>> notice something is missing, or don't find the file, or have to wait
>> for regeneration when the app notices a file without a tumb. 
>> That could take some time if you moved a directory full of postscript
>> files, for example.
>
> Use hash + filename in ~/.thumbcache and be smart when trying to find a
> thumbnail. That really can all be done in userspace.

Yes, it can be done. It's slow, ineffecient and dangerous (rename
a file, lose the thumbnail... so you'd have to do some garbage
collection on the thumbnail cache).

Thumbnails are actually an *excelent* example of a multistream
file. Renaming/moving a file leaves the image<->thumbnail link
intact. Removing the image removes the thumbnail. Copying the
file to another multistream-file capable machine also copies the
thumbnail, saving you the time to regenerate the thumbnail.
When the target machine doesn't understand a multistream file,
you simply lose the thumbnail, no harm done.

-- 
Erik Hensema <erik@hensema.net>
