Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUCRTmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUCRTmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:42:01 -0500
Received: from mail44-s.fg.online.no ([148.122.161.44]:32701 "EHLO
	mail44-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261879AbUCRTl6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:41:58 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] alignment problem in net/core/flow.c:flow_key_compare
References: <yw1x8yhyv33l.fsf@kth.se> <yw1x4qsmv1kq.fsf@kth.se>
	<20040318103004.2cf4de34.davem@redhat.com>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 18 Mar 2004 20:41:48 +0100
In-Reply-To: <20040318103004.2cf4de34.davem@redhat.com> (David S. Miller's
 message of "Thu, 18 Mar 2004 10:30:04 -0800")
Message-ID: <yw1xhdwmhrib.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Thu, 18 Mar 2004 12:25:57 +0100
> mru@kth.se (Måns Rullgård) wrote:
>
>> mru@kth.se (Måns Rullgård) writes:
>> 
>> > The solutions I see are either to force the alignment of struct flowi
>> > to 64 bits, or to use 32-bit access in flow_key_compare.
>> 
>> I forgot to mention that this is kernel 2.6.4.
>
> Yes, just add an alignment attribute of some kind to the struct
> is probably the best idea.

What's the proper way of doing that in kernel code?  Should I use gcc
__attribute__ directly or is there some macro that's preferred?

-- 
Måns Rullgård
mru@kth.se
