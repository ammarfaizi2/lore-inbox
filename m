Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUCBNxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 08:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUCBNxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 08:53:20 -0500
Received: from mail.tmr.com ([216.238.38.203]:16910 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261650AbUCBNxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 08:53:19 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.4-rc1-mm1
Date: 2 Mar 2004 13:52:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <c223i3$o1s$1@gatekeeper.tmr.com>
References: <20040229140617.64645e80.akpm@osdl.org> <20040229222415.A32236@infradead.org>
X-Trace: gatekeeper.tmr.com 1078235523 24636 192.168.12.62 (2 Mar 2004 13:52:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040229222415.A32236@infradead.org>,
Christoph Hellwig  <hch@infradead.org> wrote:
| On Sun, Feb 29, 2004 at 02:06:17PM -0800, Andrew Morton wrote:
| > +scsi-external-build-fix.patch
| > 
| > Fix scsi.h for inclusion by userspace apps - it used to work, so...
| 
| This has been rejected on linux-scsi a few times.  Don't use include/scsi/
| from the kerneltree - there's alredy a /usr/include/scsi from glibc anyway,
| so the situation is even more clear thæn the general you should not include
| kernel headers thing.

But the glibc headers don't describe 2.6, do they? Don't work with 2.6?
We went around with this for cdrecord unless I misread which headers are
involved.

It's not reasonable to expect people to rebuild glibc for each kernel,
even if it is "the right thing to do" in some purist sense. It would be
better to have something like user header in the kernel for just the
interface, and have the kernel include start by pulling in the user
header and then adding things the user doesn't need.

Changes between kernel series are always unpleasant during the time when
people have to boot back and forth, we should think about a better way
to do this for 2.7.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
