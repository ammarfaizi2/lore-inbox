Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265345AbSKEXbR>; Tue, 5 Nov 2002 18:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265343AbSKEXbQ>; Tue, 5 Nov 2002 18:31:16 -0500
Received: from almesberger.net ([63.105.73.239]:47625 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265336AbSKEXbO>; Tue, 5 Nov 2002 18:31:14 -0500
Date: Tue, 5 Nov 2002 20:37:04 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, jw@pegasys.ws,
       rml@tech9.net, andersen@codepoet.org, woofwoof@hathway.com
Subject: Re: ps performance sucks
Message-ID: <20021105203704.K1408@almesberger.net>
References: <200211052139.gA5LdIc373506@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211052139.gA5LdIc373506@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Nov 05, 2002 at 04:39:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> If you're going to do that, then specify stuff via the filename:
> /proc/12345/hack/80basic,20pids,20uids,40argv,4tty,4stat

Well, you'd get the numbers (sizes) from the kernel, as a
response. Of course, you could define the interface such that
the query (after all, that's what it is) contains the full
field name plus size information, and the kernel just says
"EINVAL" if it doesn't like it, but then you lose some
flexibility. Might not be a big deal, though.

Yeah, perhaps it's actually better to avoid being overly
clever. How frequently are ps and friends hit by the removal
of fields or size changes anyway ?

Oh, BTW, it would be more like /proc/hack/<query>, so you do
all PIDs in one sweep.

> Not that I care for dealing with the above!

Well, that's what programs are for :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
