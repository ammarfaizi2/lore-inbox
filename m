Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSGOKQR>; Mon, 15 Jul 2002 06:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSGOKQQ>; Mon, 15 Jul 2002 06:16:16 -0400
Received: from holomorphy.com ([66.224.33.161]:6824 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315459AbSGOKQL>;
	Mon, 15 Jul 2002 06:16:11 -0400
Date: Mon, 15 Jul 2002 03:17:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020715101751.GG23693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Matthew Wilcox <willy@debian.org>,
	Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk> <20020714010506.GW23693@holomorphy.com> <20020714102219.A9412@in.ibm.com> <20020714101730.GZ23693@holomorphy.com> <20020715145521.C15298@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020715145521.C15298@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 03:17:30AM -0700, William Lee Irwin III wrote:
>> I actually suspect tty-related things are a likely culprit as
>> significant use of the serial console occurs.

On Mon, Jul 15, 2002 at 02:55:21PM +0530, Dipankar Sarma wrote:
> It should also be possible to make minimal non-smptimers 
> bhless_timer patch - just in case smptimers isn't going in
> any time soon. It will run a timer tasklet off of do_timer().
> The tasklet handler still has to grab global_bh_lock and
> the likes to keep the tty and other drivers that expect
> serialization BH and timers or use __global_cli, happy.
> Will such a patch be useful ?

The temporary "hangs" are so bad any way to mitigate this horrible
problem will be useful. The machine is stuck so long in this stuff
literal network timeouts occur. It's insanely bad, this is really
beyond the scope of a performance problem and into the realm of an
out-and-out bug. A machine stuck for that long in this code is
effectively dead. I'm just slightly more patient than average users.


Cheers,
Bill
