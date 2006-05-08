Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWEHQCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWEHQCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEHQCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:02:48 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:59047 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S932414AbWEHQCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:02:47 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Date: Mon, 8 May 2006 16:02:46 +0000 (UTC)
Organization: Cistron
Message-ID: <e3nq36$vnq$1@news.cistron.nl>
References: <200605051010.19725.jasons@pioneer-pra.com> <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org> <20060508154217.GH1875@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1147104166 32506 194.109.0.112 (8 May 2006 16:02:46 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20060508154217.GH1875@harddisk-recovery.com>,
Erik Mouw  <erik@harddisk-recovery.com> wrote:
>On Mon, May 08, 2006 at 05:31:29PM +0200, Arjan van de Ven wrote:
>> On Mon, 2006-05-08 at 17:22 +0200, Erik Mouw wrote:
>> > ... except that any kernel < 2.6 didn't account tasks waiting for disk
>> > IO.
>> 
>> they did. It was "D" state, which counted into load average.
>
>They did not or at least to a much lesser extent.

I just looked at the 2.4.9 (random 2.4 kernel) source code, and
kernel/timer.c::count_active_tasks(), which is what calculates the
load average, uses the same algorithm as in 2.6.16

Mike.

