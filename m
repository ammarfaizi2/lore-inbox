Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbTEAWni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTEAWni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:43:38 -0400
Received: from beauty.rexursive.com ([202.59.98.58]:35077 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S262735AbTEAWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:43:37 -0400
Subject: Re: 2.5.68: NFS3+exported /mnt/cdrom+eject: system lockup
From: Bojan Smojver <bojan@rexursive.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <shsd6j3gdan.fsf@charged.uio.no>
References: <1051754203.3eb07edb09c51@imp.rexursive.com>
	 <shsd6j3gdan.fsf@charged.uio.no>
Content-Type: text/plain
Organization: Rexursive
Message-Id: <1051829732.1529.2.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 May 2003 08:55:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 20:40, Trond Myklebust wrote:
> >>>>> " " == Bojan Smojver <bojan@rexursive.com> writes:
> 
>      > NFS3 server was running on the box and it was exporting a
>      > mounted /mnt/cdrom to the world. On "umount /mnt/cdrom" it
>      > reported "device busy". On "eject /mnt/cdrom" it locked the
>      > system hard.
> 
>      > What kind of information would help debugging this?
> 
> The only bug there is the hard crash. You are never allowed to unmount
> a device that has been exported.

Yeah, I guessed that much. I was actually expecting another "device
busy", which is OK. Crash, not OK :-)

Anyway, I have observed other strange stuff too, like not being able to
unmount /mnt/cdrom while it's being exported. Workaround: stop NFS,
unmount, start NFS. Not sure if this is normal or not...

-- 
Bojan

