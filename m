Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbRFGRMP>; Thu, 7 Jun 2001 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbRFGRMF>; Thu, 7 Jun 2001 13:12:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19245 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262094AbRFGRMA>; Thu, 7 Jun 2001 13:12:00 -0400
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Hans Reiser <reiser@namesys.com>,
        Andrej Borsenkow <Andrej.Borsenkow@mow.siemens.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: NULL characters in file on ReiserFS again.
In-Reply-To: <000201c0e9c5$7643d540$21c9ca95@mow.siemens.ru>
	<3B16780F.D5FF04D8@namesys.com> <20010606172209.A3362@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 11:04:59 -0600
In-Reply-To: <20010606172209.A3362@redhat.com>
Message-ID: <m1d78g43wk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> writes:

> Hi,
> 
> On Thu, May 31, 2001 at 09:57:51AM -0700, Hans Reiser wrote:
> 
> > > /etc/hosts (or anywhere). As a tesult, startx hung starting X server; it was
> 
> > > not possible to switch to alpha console or kill X server. I pressed reset
> > > and after reboot looked into /var/log/XFree86*log - and there were a bunch
> > > of ^@ there.
> 
> > this is the nature of metadata journaling filesystems.
> 
> Umm, no, it isn't.  Ext3 would never allow that to happen in ordered
> metadata-journaling mode, and Chris Mason is already working to remove
> that window in reiserfs.  It is by no means a necessary consequence of
> doing metadata-only journaling.

Hans seemed to be refering to the fact that fsck.reiser returned
without errors on the partition being looked at.  Which is the nature
of metadata journalling.  The filesystem doesn't get corrupted though
the files might. 

Eric
