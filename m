Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTJQExg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 00:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTJQExg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 00:53:36 -0400
Received: from holomorphy.com ([66.224.33.161]:42886 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263302AbTJQExf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 00:53:35 -0400
Date: Thu, 16 Oct 2003 21:56:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Brian McGroarty <brian@mcgroarty.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       lm@bitmover.com
Subject: Re: /proc reliability & performance
Message-ID: <20031017045615.GB25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Brian McGroarty <brian@mcgroarty.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	lm@bitmover.com
References: <1066356438.15931.125.camel@cube> <20031017032436.GA17480@mcgroarty.net> <1066365074.15931.195.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066365074.15931.195.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 12:31:14AM -0400, Albert Cahalan wrote:
> Count tasks as you read them. The number is
> your directory offset. Return a few dozen entries
> at a time. For each read, you'll need to find
> back your place. You do this by counting tasks
> until you reach your offset. Of course, tasks
> will have been created and destroyed between
> reads, so who knows where you'll continue from?
> That's simply not reliable.

That's part of what the rbtree algorithm was meant to address.
It does find_tgids_after(tgids, tgid_array), filling a buffer with the
tgids starting at the first one higher than its first argument. This
way there is no possibility whatsoever of duplicates or deviation from
sorted order.


-- wli
