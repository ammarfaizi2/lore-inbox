Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUAGS6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUAGS6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:58:11 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:53109 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264936AbUAGS55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:57:57 -0500
Subject: Re: XFS over 7.7TB LVM partition through NFS
From: Eric Sandeen <sandeen@sgi.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
In-Reply-To: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
References: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
Content-Type: text/plain
Organization: Eric Conspiracy Secret Labs
Message-Id: <1073501867.23356.5.camel@stout.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2004 12:57:48 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to get this out of the way, I assume CONFIG_LBD is turned on?
I think so, otherwise it should not mount.

Also, is below an oops, or an xfs corruption message, or...?  What came
before the call trace.

fsck won't do anything, fsck.xfs is a no-op.

You could run xfs_repair over the fs to see what it finds.

Also please include xfs_info output for the filesystem, and whether you
expect that any clients are writing files > 4G...

And, that stack looks awfully long if it's real, turning on the stack
overflow check in the kernel might be interesting.

-Eric

On Wed, 2004-01-07 at 11:36, Jirka Kosina wrote:
> Hi,
> 
> I am experiencing problems with LVM2 XFS partition in 2.6.0 being accessed 
> over NFS. After exporting the filesystem clients start writing files to 
> this partition over NFS, and after a short while we get this call trace, 
> repeating indefinitely on the screen and the machine stops responding 
> (keyboard, network):

-- 
Eric Sandeen      [C]XFS for Linux   http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.          651-683-3102

