Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbTGKApc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269726AbTGKApb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:45:31 -0400
Received: from holomorphy.com ([66.224.33.161]:25269 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269725AbTGKApX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:45:23 -0400
Date: Thu, 10 Jul 2003 18:01:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Message-ID: <20030711010122.GZ15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <bejhrj$dgg$1@news.cistron.nl> <20030710112728.GX15452@holomorphy.com> <bejnl9$m9l$1@news.cistron.nl> <20030710155643.GY15452@holomorphy.com> <bekrg1$c9m$2@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bekrg1$c9m$2@news.cistron.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030710155643.GY15452@holomorphy.com>, William Lee Irwin III  <wli@holomorphy.com> wrote:
>> That's not what it's supposed to do. The thought behind it is that since
>> out_of_memory()'s count is not reset unless it's been 5s since the last
>> time this was ever invoked, it will happen on a regular basis after the
>> first kill if it is invoked regularly. It's actually a bit too late,
>> since something's already been killed, but it should make a larger
>> difference than merely altering the rate.

On Thu, Jul 10, 2003 at 11:05:37PM +0000, Miquel van Smoorenburg wrote:
> Well, that won't help in my case, as my problem is not that many
> processes are killed - it's just that every few minutes (sometimes
> 3 minutes, sometimes 30, sometimes an hour) an innocent process
> gets killed (just one) with 2.5.74-mm3. And that did not happen 
> with 2.5.74 or 2.5.72-mm2

Okay, it won't help your case, then. I've had this improvement to its
heuristics on the back burner for a while but haven't gone so far as
to dig up a case it directly benefits. It's small enough I'll think
about it later.


-- wli
