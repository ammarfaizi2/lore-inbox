Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTJNRvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTJNRvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:51:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50588 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262683AbTJNRv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:51:29 -0400
Date: Tue, 14 Oct 2003 10:45:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: shep@alum.mit.edu, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, netdev@oss.sgi.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] fix numbering of lines in /proc/net/tcp
 (linux-2.6.0-test7)
Message-Id: <20031014104503.12ca907e.davem@redhat.com>
In-Reply-To: <20031015.013848.133364889.yoshfuji@linux-ipv6.org>
References: <200310141619.h9EGJWWB013461@ginger.lcs.mit.edu>
	<20031015.013848.133364889.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 01:38:48 +0900 (JST)
YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:

> In article <200310141619.h9EGJWWB013461@ginger.lcs.mit.edu> (at Tue, 14 Oct 2003 12:19:32 -0400), Tim Shepard <shep@alum.mit.edu> says:
> 
> > I am not sure what the behavior is supposed to be.  Is there a spec
> > anywhere for the interface with /proc/net/tcp?
> 
> Yes, I think the original is okay because the bucket is shared between
> tcp6 and tcp4, and I don't want to change this behavior in 2.6 from 2.4.x.
> (so, we need to fix 2.6.x.)

In the meantime I've applied Tim's patch because it is definitely
a step in the right direction and the current 2.6.x behavior makes
no sense at all :-)

We can add a fix on top to make 2.6.x behave more closely to 2.4.x
(by sharing numbers between v4 and v6).  If that proves to be very
difficult to do, it's not absolutely critical to preserve this behavior
I think.
