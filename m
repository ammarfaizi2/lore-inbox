Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWFTVVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWFTVVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFTVVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:21:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:1423 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751108AbWFTVVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:21:40 -0400
Date: Tue, 20 Jun 2006 16:21:34 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 0/12] eCryptfs minor fixes; support for cipher/key size selection
Message-ID: <20060620212134.GB18701@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 12-part patch set includes several minor updates, but the main
feature is that eCryptfs can support a user-selectable cipher and key
size at mount time. Once these patches are applied, users will need to
update to the new userspace util package for the mount helper, which
is named ``ecryptfs-util-git-2.6.17-rc6-mm2++.tar.bz2'' and is
available from the eCryptfs SourceForge site:

http://sourceforge.net/project/showfiles.php?group_id=133988

eCryptfs enthusiasts may notice that we got rid of all the shell
scripts and implemented the whole mount helper in natively compiled
code; we are also a bit more careful with how we handle sensitive
passphrase material in memory. We do quite a bit of work with trying
to auto-detect available ciphers provided by the kernel. We would
appreciate folks who have the time to review that userspace code and
let us know if you have any suggestions as to how we could do things
better in that area.

Thanks to our interns, Tyler Hicks, Theresa Nelson, and Trevor
Highland for contributing the majority of the kernel and userspace
code toward cipher selection functionality. They are now hard at work
getting public key support implemented.

Thanks,
Mike
