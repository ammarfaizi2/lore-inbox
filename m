Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUBDAnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUBDAnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:43:39 -0500
Received: from gprs156-172.eurotel.cz ([160.218.156.172]:52096 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265969AbUBDAnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:43:37 -0500
Date: Wed, 4 Feb 2004 01:43:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: the grugq <grugq@hcunix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040204004318.GA253@elf.ucw.cz>
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40203DE1.3000302@hcunix.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Perhaps this should still be controlled by (chattr(1)) [its already
> >documented, just not yet implemented].
> >
> >       When a file with the `s' attribute set is deleted, its blocks
> >	are zeroed and written back to the disk.
> >
> >...at which point config option is not really neccessary.
> >
> 
> You're not the first person to mention this to me, Pádraig, brought this 
> up on the day I posted. I certainly thing the 's' options should be 
> implemented, however for a privacy patch I believe that the user 
> shouldn't have to intervene to ensure a file is securely erased. It 
> makes more sense to me, as a lazy person, that the file system should be 
> set to always remove the file content... that way the user doesn't need 
> to get involved.
> 
> All that said, the user's content is something that the user could be 
> considered responsible for erasing themselves. The meta-data is the part 
> of the file which they dont' have access to, so having privacy 
> capabilities for meta-data erasure is a requirement. User data 
> erasure... I can take it or leave it. I think it should be automatic if 
> at all, but I'm not really that bothered about it.

Well, doing it on-demand means one less config option, and possibility
to include it into 2.7... It should be easy to have tiny patch forcing
that option always own for your use...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
