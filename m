Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUBDBYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUBDBYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:24:53 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49884 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264329AbUBDBYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:24:52 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3-mm1
Date: Wed, 4 Feb 2004 02:29:05 +0100
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
References: <20040202235817.5c3feaf3.akpm@osdl.org> <200402040135.56602.bzolnier@elka.pw.edu.pl> <200402040103.36504.s0348365@sms.ed.ac.uk>
In-Reply-To: <200402040103.36504.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402040229.05918.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 of February 2004 02:03, Alistair John Strachan wrote:
> On Wednesday 04 February 2004 00:35, Bartlomiej Zolnierkiewicz wrote:
> [snip]
>
> > Oh yes, I am stupid^Wtired.  Maybe it is init_idedisk_capacity()?.
> > Can you add some more printks to idedisk_setup() to see where it hangs?
>
> I did this, and it appears to hang where you suspected,
> init_idedisk_capacity(). If this a useful datapoint, I haven't boot-tested

init_idedisk_capacity()->idedisk_check_hpa()->
->idedisk_read_native_max_address_{ext}() is a first disk access.

Probably it hangs there.  Hmm. more printks? :-)

> a kernel since 2.6.2-rc1-mm1. I can test 2.6.2-rc3 if you're puzzled by
> this result.

Does this system work ok with 2.6.2-rc1-mm1?  Weird.

--bart

