Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUHFMCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUHFMCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 08:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUHFMCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 08:02:15 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:53125 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265825AbUHFMCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 08:02:13 -0400
Date: Fri, 6 Aug 2004 14:01:23 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806120123.GA23081@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <20040806104630.GA17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806104630.GA17188@holomorphy.com>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ fixed linux-mm address ]

On Fri, 06 Aug 2004 03:46:30 -0700, William Lee Irwin III wrote:
> On Fri, Aug 06, 2004 at 11:40:37AM +0200, Roger Luethi wrote:
> > I discussed this very issue with wli on linux-mm about a year ago. proc
> > file and documentation are still broken. So what's wrong with doing
> > something about it?
> 
> So now what, you want me to do yet another forward port of
> linux-2.4.9-statm-B1.diff?

Your call, obviously -- do you think it's worthwhile? I didn't CC you
on my initial posting because I wanted to avoid the impression that I am
trying to make this your problem somehow. Priorities as I see them are:

- Document statm content somewhere. I posted a patch to document
  the current state. It could be complemented with a description of
  what it is supposed to do.

- Come to some agreement on what the proper values should be and
  change kernels accordingly. I'm inclined to favor keeping the first two
  (albeit redundant) fields and setting the rest to 0, simply because for
  them too many different de-facto semantics live in exisiting kernels.

  A year ago, the first field was broken in 2.4 as well (not sure if/when
  it got fixed), but I can see why it is useful to keep around until top
  has found a better source. Same for the second field, the only one that
  has always been correct AFAIK.

- Provide additional information in proc files other than statm.

  The problems with undocumented records are evident, but
  /proc/pid/status may be getting too heavy for frequent parsing. It's
  not realistic to redesign proc at this point, but it would be nice
  to have some documented understanding about the direction of proc
  evolution.

Roger
