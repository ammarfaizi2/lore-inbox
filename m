Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTEAK2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 06:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbTEAK2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 06:28:40 -0400
Received: from pat.uio.no ([129.240.130.16]:28347 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261201AbTEAK2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 06:28:39 -0400
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68: NFS3+exported /mnt/cdrom+eject: system lockup
References: <1051754203.3eb07edb09c51@imp.rexursive.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 01 May 2003 12:40:48 +0200
In-Reply-To: <1051754203.3eb07edb09c51@imp.rexursive.com>
Message-ID: <shsd6j3gdan.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bojan Smojver <bojan@rexursive.com> writes:

     > NFS3 server was running on the box and it was exporting a
     > mounted /mnt/cdrom to the world. On "umount /mnt/cdrom" it
     > reported "device busy". On "eject /mnt/cdrom" it locked the
     > system hard.

     > What kind of information would help debugging this?

The only bug there is the hard crash. You are never allowed to unmount
a device that has been exported.

Cheers,
  Trond
