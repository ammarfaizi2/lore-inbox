Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264078AbSIVMNg>; Sun, 22 Sep 2002 08:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264090AbSIVMNf>; Sun, 22 Sep 2002 08:13:35 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:6166 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264078AbSIVMNe>;
	Sun, 22 Sep 2002 08:13:34 -0400
Date: Sun, 22 Sep 2002 14:18:43 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020922121843.GA15967@win.tue.nl>
References: <20020921161702.GA709@iucha.net> <597384533.1032600316@[10.10.2.3]> <20020921185939.GA1771@iucha.net> <20020921202353.GA15661@win.tue.nl> <20020922043050.GU3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020922043050.GU3530@holomorphy.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 09:30:50PM -0700, William Lee Irwin III wrote:

> On Sat, Sep 21, 2002 at 10:23:53PM +0200, Andries Brouwer wrote:
> > I noticed that the pgrp-related behaviour of some programs changed.
> > Some programs hang, some programs loop. The hang occurs when they
> > are stopped by SIGTTOU. The infinite loop occurs when they catch SIGTTOU
> > (and the same signal is sent immediately again when they leave the
> > signal routine).
> > Have not yet investigated details.
> 
> Linus seems to have put out 2.5.38 with some X lockup fixes. Can you
> still reproduce this? If so, are there non-X-related testcases where
> you can trigger this? My T21 Thinkpad doesn't see this at all.
> 
> I'm still prodding the SIGTTOU path trying to trigger it until then.

Yes, 2.5.38 behaves differently again, but the statement that
pgrp-related behaviour of some programs changed is still true.

For example: "emacs -nw foo.c" in an xterm window
will start emacs fine. Now put this line in a shell script:
	#!/bin/sh
	emacs -nw $@
so that pid and pgrp of the started emacs differ. Under 2.5.33
this works, but under 2.5.3[78] this hangs.

Andries
