Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVBYVC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVBYVC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVBYVC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:02:29 -0500
Received: from calma.pair.com ([209.68.1.95]:19985 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S261387AbVBYVC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:02:26 -0500
Date: Fri, 25 Feb 2005 16:02:26 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Paulo Marques <pmarques@grupopie.com>, Chris Friesen <cfriesen@nortel.com>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050225210225.GA89109@calma.pair.com>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com> <20050225202543.GA1249@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225202543.GA1249@hh.idb.hist.no>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's so special about a 64-way box?

They're expensive and customers don't expect a single userspace thread to
tie up the other 63 CPUs no matter how buggy it is.  It is intuitively obvious
that a buggy kernel can bring a system to its knees, but it is not intuitively
obvious that a buggy userspace app can do the same thing.  It is more of a 
supportability issue than anything, because you expect the other processors
to function properly so you can get in and live-debug the application when it
hits a bug that makes it CPU-bound.  This is especially important if the box 
is, say, in a remote jungle of China or something where you don't have access 
to the console.

The horse is dead, so lets not beat it anymore for the time being.  It is 
quite clear that people don't want Linux to (by default) not have the gun
cocked and pointed at the application developer's feet.  People who want a 
kernel that doesn't hang in the face of bad-acting userspace apps can change
the priority of important kernel threads, which seems like a reasonable 
workaround for now.

Regards,

Chad
