Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbULBUsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbULBUsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbULBUsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:48:16 -0500
Received: from mail.joq.us ([67.65.12.105]:46772 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261766AbULBUsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:48:13 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Andrew Burgess <aab@cichlid.com>,
       linux-kernel@vger.kernel.org, jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
References: <200412021546.iB2FkK5a005502@cichlid.com>
	<20041202170315.067d7853@mango.fruits.de>
	<87y8ggekds.fsf@sulphur.joq.us>
	<20041202175756.0e50f101@mango.fruits.de>
	<87hdn4eihw.fsf@sulphur.joq.us>
	<1102018036.31206.8.camel@krustophenia.net>
From: "Jack O'Quin" <joq@io.com>
Date: 02 Dec 2004 14:48:23 -0600
In-Reply-To: <1102018036.31206.8.camel@krustophenia.net>
Message-ID: <87zn0wctpk.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Thu, 2004-12-02 at 11:07 -0600, Jack O'Quin wrote:
> > Is printk() guaranteed not to wait inside the kernel?  I am not
> > familiar with its internal implementation.
> 
> Yes.  It just writes to a ring buffer and klogd dumps this to syslog.
> So if you really start to spew printk's they don't all make it to the
> log but you never get blocked.
> 
> The implementation probably looks a lot like a correct solution to fix
> the printf-from-RT-context issue in JACK would.

Right.  That's exactly what I have in mind, whenever I find time to
work on it.  :-)

There's some similar code I wrote for JAMin, which we could adapt.
-- 
  joq
