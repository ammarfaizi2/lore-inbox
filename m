Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263553AbRFFQZt>; Wed, 6 Jun 2001 12:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263540AbRFFQZi>; Wed, 6 Jun 2001 12:25:38 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:24056 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263546AbRFFQZX>; Wed, 6 Jun 2001 12:25:23 -0400
Date: Wed, 6 Jun 2001 17:22:09 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrej Borsenkow <Andrej.Borsenkow@mow.siemens.ru>,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: NULL characters in file on ReiserFS again.
Message-ID: <20010606172209.A3362@redhat.com>
In-Reply-To: <000201c0e9c5$7643d540$21c9ca95@mow.siemens.ru> <3B16780F.D5FF04D8@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B16780F.D5FF04D8@namesys.com>; from reiser@namesys.com on Thu, May 31, 2001 at 09:57:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 31, 2001 at 09:57:51AM -0700, Hans Reiser wrote:

> > /etc/hosts (or anywhere). As a tesult, startx hung starting X server; it was
> > not possible to switch to alpha console or kill X server. I pressed reset
> > and after reboot looked into /var/log/XFree86*log - and there were a bunch
> > of ^@ there.

> this is the nature of metadata journaling filesystems.

Umm, no, it isn't.  Ext3 would never allow that to happen in ordered
metadata-journaling mode, and Chris Mason is already working to remove
that window in reiserfs.  It is by no means a necessary consequence of
doing metadata-only journaling.

--Stephen
