Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVBCMnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVBCMnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 07:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVBCMmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 07:42:02 -0500
Received: from ns2.cltechnet.com ([202.154.106.173]:6579 "EHLO
	ns2.cltechnet.com") by vger.kernel.org with ESMTP id S263292AbVBCMkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 07:40:06 -0500
Subject: Re: [fuse-devel] [ANNOUNCE] Filesystem in Userspace - 2.2
From: Franco Broi <franco@cltechnet.com>
Reply-To: franco@robres.com
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <E1CwfAs-0000aE-00@dorka.pomaz.szeredi.hu>
References: <E1CwfAs-0000aE-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 20:39:22 +0800
Message-Id: <1107434362.3881.9.camel@palmy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-CyberLink-MailScanner-Information: Please contact the ISP for more information
X-CyberLink-MailScanner: Found to be clean
X-MailScanner-From: franco@cltechnet.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just ported my filesystem to 2.2-pre6 and was able to throw away
about 300 lines of code, the filehandle stuff is great. I was hoping to
give it a thorough test and report back before 2.2 was released but you
beat me to it.

It just keeps getting better and better, well done!


On Thu, 2005-02-03 at 12:29 +0100, Miklos Szeredi wrote:
> FUSE version 2.2 is out there:
> 
>   http://sourceforge.net/project/showfiles.php?group_id=121684&package_id=132802&release_id=301878
> 
> This can be used standalone or with recent -mm kernels (with the
> exception of -rc2-mm2).
> 
> Most notable changes since 2.1:
> 
>   - Added file handle parameter to open/read/write/release.  This
>     should make life easier for filesystems wanting to implement
>     stateful I/O.
> 
>   - Added compatibility to the 2.1 and to some extent to the 1.X API
> 
>   - Re-added ability to interrupt operations.  This time more
>     carefully than in 1.X.
> 
> Regressions:
> 
>   - Removed shared-writable mmap support, which could deadlock the
>     linux memory subsystem.  This should not affect most people, but
>     if some application breaks for you, I'd like to hear about it.
> 
>   - Made the readpages() operation synchronous, again for deadlock
>     considerations.  This can degrade performance, especially for high
>     latency filesystems, since previously parallel read-ahead is now
>     serialized.
> 
> In the long run I hope to solve both problems, but neither is trivial.
> Ideas are welcome, as well as bugreports of course.
> 
> Thanks,
> Miklos
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> fuse-devel mailing list
> fuse-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/fuse-devel

