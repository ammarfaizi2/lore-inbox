Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTDIAwf (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTDIAwf (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:52:35 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:3024 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S261896AbTDIAwa (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:52:30 -0400
Date: Tue, 8 Apr 2003 18:02:51 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030409010250.GZ31739@ca-server1.us.oracle.com>
References: <20030408195305.F19288@almesberger.net> <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com> <b6vnig$q86$1@cesium.transmeta.com> <Pine.LNX.4.44.0304090225440.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304090225440.12110-100000@serv>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 02:40:24AM +0200, Roman Zippel wrote:
> > a) There are, genuinely, systems with more than 65,536 devices or
> > anonymous mounts.  That rules out the current dev_t just by itself.
> 
> Absolutely nobody denies that we need a larger dev_t. It's really a poor 
> argumentation that you have to come up with this.

Roman,
	There are a couple things being discussed here.  One is the size
of dev_t.  The other is dynamic numbers.  It would seem that most folks
agree with a larger dev_t and a more dynamic numbering system.  Let's
assume we want both for now (folks who don't, please keep out for a
second).  There are three courses of action that seem to be advocated.

1) Ship 2.6 with 16bit dev_t, work on a larger dev_t and perfect dynamic
   devices in 2.7.
2) Ship 2.6 with a (32|64)bit dev_t, work on a perfect dynamic scheme in
   2.7.
3) Hold 2.6 until it can ship with (32|64)bit dev_t and perfect dynamic
   devices.

	Many folks, Peter and myself included, are claiming that choice
(1) is absolutely untenable.  We need more device space today, not in 3
years when 2.7 becomes 2.8.
	If I understand you correctly (and here is why I mailed), you
feel that choice (2) is the worst of the choices.  You feel that we
should either choose course (1) or course (3).  I'm not sure which of
those you prefer.
	
Joel


-- 

Life's Little Instruction Book #335

	"Every so often, push your luck."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
