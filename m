Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWGFRFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWGFRFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWGFRFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:05:50 -0400
Received: from khc.piap.pl ([195.187.100.11]:54669 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S965197AbWGFRFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:05:49 -0400
To: ric@emc.com
Cc: Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl> <44AD286F.3030507@emc.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 06 Jul 2006 19:05:48 +0200
In-Reply-To: <44AD286F.3030507@emc.com> (Ric Wheeler's message of "Thu, 06 Jul 2006 11:12:47 -0400")
Message-ID: <m3ejwyiryr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ric Wheeler <ric@emc.com> writes:

> Having a checksum (or even a digital signature on a file) that lets us
> detect corruption is very useful since, in many cases, it allows us to
> flag the file as corrupt before it gets used.

We can't have that. Sector/block/etc. checksums - yes.

A checksum, signature, hash etc. of the whole file would require
actually reading the whole file. It can be done by tripwire or
backup, and even by fsck, but not by the filesystem in normal
operation.
-- 
Krzysztof Halasa
