Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUDOU1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUDOUZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:25:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25774 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262175AbUDOUY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:24:29 -0400
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Firewire still broken in 2.6.5 (also broken in 2.6.4, worked in 2.6.3)
References: <20040415183230.GA16458@codeblau.de>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 15 Apr 2004 17:24:09 -0300
In-Reply-To: <20040415183230.GA16458@codeblau.de>
Message-ID: <or3c75dm6u.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 15, 2004, Felix von Leitner <felix-kernel@fefe.de> wrote:

> In 2.6.4, the kernel would detect my cold plugged Maxtor disk, but then
> freeze and eventually time out trying to mount the file system on it in
> the boot process.

> In 2.6.5, largely the same, but the kernel works when the disk is hot
> plugged in after the boot process.  Having it plugged in during the boot
> process still fails, and unplugging and replugging it after the boot
> process still fails.

> After a few write accesses on the file system, however, 2.6.5 panics.

> Is this a known problem?  Anyone working on it?

Yup.  There seems to have been some progress in this regard in the
linux1394 mailing lists and SVN repository, but it's still a bit
unstable.

Personally, I've been using the 2.6.3 ieee1394 sources in newer kernel
releases, and it's been working very well.  Perhaps we should revert
drivers/ieee1394 to the 2.6.3 state until the problems are addressed
in the linux1394 repository, to only then have it merged here.
What we have now was a merge of a non-functional state of the tree,
which servers nobody.

I can easily provide a patch to restore the working state, if people
think this would be a good idea.  Just say the word.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
