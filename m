Return-Path: <linux-kernel-owner+w=401wt.eu-S1422734AbXAHUtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbXAHUtf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422745AbXAHUte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:49:34 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:55177 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422734AbXAHUtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:49:33 -0500
Date: Mon, 8 Jan 2007 21:24:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Shaya Potter <spotter@cs.columbia.edu>
cc: Andrew Morton <akpm@osdl.org>, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
In-Reply-To: <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
Message-ID: <Pine.LNX.4.61.0701082122460.23737@yvahk01.tjqt.qr>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
 <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org>
 <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 14:43, Shaya Potter wrote:
> On Mon, 8 Jan 2007, Andrew Morton wrote:
>> On Sun,  7 Jan 2007 23:12:53 -0500
>> "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
>> 
>> > +Modifying a Unionfs branch directly, while the union is
>> > +mounted, is currently unsupported.
>> 
>> Does this mean that if I have /a/b/ and /c/d/ unionised under
>> /mnt/union, I am not allowed to alter anything under /a/b/
>> and /c/d/?  That I may only alter stuff under /mnt/union?
>> 
>> If so, that sounds like a significant limitation.
>
> haven't we been through this?  It's the same thing as
> modifying a block device while a file system is using it. 
> Now, when unionfs gets confused, it shouldn't oops, but would
> one expect ext3 to allow one to modify its backing store while
> its using it?

(Blunt counter-example: Modifying the underlying filesystem of
an NFS import does not break. But I agree with Shaya.)

Well it was suggested to make /a/b and /c/d read-only while the
union is mounted, using a ro bind mount, what about it? (To
catch unwanted tampering with the lowlevels)

	-`J'
-- 
