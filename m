Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUHFML2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUHFML2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 08:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUHFML1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 08:11:27 -0400
Received: from holomorphy.com ([207.189.100.168]:36555 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265879AbUHFMLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 08:11:25 -0400
Date: Fri, 6 Aug 2004 05:11:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806121118.GE17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <20040806104630.GA17188@holomorphy.com> <20040806120123.GA23081@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806120123.GA23081@k3.hellgate.ch>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 02:01:23PM +0200, Roger Luethi wrote:
> Your call, obviously -- do you think it's worthwhile? I didn't CC you
> on my initial posting because I wanted to avoid the impression that I am
> trying to make this your problem somehow. Priorities as I see them are:
> - Document statm content somewhere. I posted a patch to document
>   the current state. It could be complemented with a description of
>   what it is supposed to do.
> - Come to some agreement on what the proper values should be and
>   change kernels accordingly. I'm inclined to favor keeping the first two
>   (albeit redundant) fields and setting the rest to 0, simply because for
>   them too many different de-facto semantics live in exisiting kernels.
>   A year ago, the first field was broken in 2.4 as well (not sure if/when
>   it got fixed), but I can see why it is useful to keep around until top
>   has found a better source. Same for the second field, the only one that
>   has always been correct AFAIK.

Some of the 2.4 semantics just don't make sense. I would not find it
difficult to explain what I believe correct semantics to be in a written
document.

The largest barrier is that the accounting has a large code impact.


On Fri, Aug 06, 2004 at 02:01:23PM +0200, Roger Luethi wrote:
> - Provide additional information in proc files other than statm.
>   The problems with undocumented records are evident, but
>   /proc/pid/status may be getting too heavy for frequent parsing. It's
>   not realistic to redesign proc at this point, but it would be nice
>   to have some documented understanding about the direction of proc
>   evolution.

It will likely be easier to merge improvements of /proc/$PID/status as
the operations there are far less frequent and the accounting less
invasive.


-- wli
