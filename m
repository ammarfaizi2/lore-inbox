Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277354AbRJEL0L>; Fri, 5 Oct 2001 07:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277355AbRJELZ6>; Fri, 5 Oct 2001 07:25:58 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:12028 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S277354AbRJELZv>; Fri, 5 Oct 2001 07:25:51 -0400
Date: Fri, 5 Oct 2001 12:25:36 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Bernd Eckenfels <ecki@lina.inka.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
Message-ID: <20011005122536.C2293@redhat.com>
In-Reply-To: <706340000.1002116485@gullevek.piwi.intern> <E15oqKN-00058k-00@calista.inka.de> <20011005113146.B3587@redhat.com> <3BBD8E82.592130A7@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBD8E82.592130A7@namesys.com>; from reiser@namesys.com on Fri, Oct 05, 2001 at 02:42:10PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 05, 2001 at 02:42:10PM +0400, Hans Reiser wrote:

> > Should be fine with ext3 and XFS.  It's not a journaling problem as
> > much as NFS assuming a particular property of the filesystem.

> Err, I meant it is stable from all reports for recent kernels:-/.... excuse me.

Yes, and it's also worth noting that this same NFS assumption will
break exports of _all_ filesystems which don't have simple static
inum/filehandle capabilities.  Reiserfs should work just fine now but
the same NFS problem is still present if you do other things such as
trying to re-export a SMB mount as NFS. 

Cheers,
 Stephen
