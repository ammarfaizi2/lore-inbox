Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291492AbSBHJLX>; Fri, 8 Feb 2002 04:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291485AbSBHJLN>; Fri, 8 Feb 2002 04:11:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291492AbSBHJLE>;
	Fri, 8 Feb 2002 04:11:04 -0500
Message-ID: <3C639603.93FFD17D@zip.com.au>
Date: Fri, 08 Feb 2002 01:10:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C639060.A68A42CA@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> It is noteworthy that the wakeup strategy has changed from wake-all to
> wake-one, which should save a few cycles.

It is also noteworthy that read latency completely sucks.  Not sure if
I've made it worse.

Anyway, with exclusive wakeup we need separate waitqueues for read and
write requests.  Updated patch at

	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/make_request.patch

-
