Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWGEL64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWGEL64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWGEL6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:58:54 -0400
Received: from mail.tmr.com ([64.65.253.246]:37276 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964815AbWGEL6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:58:53 -0400
Message-ID: <44ABAA0E.4000907@tmr.com>
Date: Wed, 05 Jul 2006 08:01:18 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Neil Brown <neilb@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <1151964720.16528.22.camel@localhost.localdomain> <17577.43190.724583.146845@cse.unsw.edu.au> <m3psglhb2o.fsf@defiant.localdomain> <20060704124905.GB11458@aitel.hist.no>
In-Reply-To: <20060704124905.GB11458@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> On Tue, Jul 04, 2006 at 01:19:11PM +0200, Krzysztof Halasa wrote:
>> Neil Brown <neilb@suse.de> writes:
>>
>>> With checksums - the filesystem is in a better position to:
>>>  - be selective about what is checksummed - no point checksumming
>>>    blocks that aren't part of any file.  Some blocks (highlevel
>>>    metadata) might always be checksummed, while other blocks
>>>    (regular data) might not if a 'fast' option was chosen.
>> The same applies to RAID - for example, why "synchronise" unused area?
>>
> Indeed.  RAID usually avoid checksumming unused area, it sums on write
> and you don't write "unused" stuff.  
> 
> Not syncing unused area is possible, if there was a way for raid resync
> to ask the fs what blocks are not in use.  I.e. get the
> free block list in disk block order.  Then raid resync could skip those.
> 
Current RAID code supports having a bitmap of dirty stripes, and can 
just sync those during recovery. I'm sure Neil could explain it better, 
but this is available without worrying about fs type. Now. Today.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

