Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSKBSMd>; Sat, 2 Nov 2002 13:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSKBSMd>; Sat, 2 Nov 2002 13:12:33 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:49863 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261374AbSKBSL4>; Sat, 2 Nov 2002 13:11:56 -0500
Cc: Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com, davej@suse.de
References: <20021101085148.E105A2C06A@lists.samba.org>
	<1036175565.2260.20.camel@mentor>
	<20021102070607.GB16100@think.thunk.org>
	<87znssytu7.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sat, 02 Nov 2002 19:18:10 +0100
Message-ID: <87d6pnzvh9.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> "Theodore Ts'o" <tytso@mit.edu> writes:
>
>> HOWEVER, if we're going to do it, Olaf's patches is really not the way
>> to do it.  If we're going to do it at all, the right way to do it is
>> via extended attributes.  Using a sparse file to store capabilities
>> indexed by inode numbers is a bad idea; it will break if the user uses
>> resize2fs on an ext2/3 filesystem, for example.
>
> Dragging yet another one out of you. This is a pretty strong argument
> against my implementation. Any other hints?

With dumping capabilities before resize and restoring them afterwards,
you can solve this. See:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/dumpcaps.pl>

Regards, Olaf.
