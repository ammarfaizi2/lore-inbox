Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWH3PNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWH3PNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWH3PNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:13:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:52174 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750995AbWH3PNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:13:23 -0400
Date: Wed, 30 Aug 2006 08:14:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: ego@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       arjan@infradead.org, rusty@rustcorp.com.au, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@intel.linux.com,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-ID: <20060830151405.GD1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060824140342.GI2395@in.ibm.com> <1156429015.3014.68.camel@laptopd505.fenrus.org> <44EDBDDE.7070203@yahoo.com.au> <20060824150026.GA14853@elte.hu> <20060825035328.GA6322@in.ibm.com> <20060827005944.67f51e92.pj@sgi.com> <20060829180511.GA1495@us.ibm.com> <20060829123102.88de61fa.pj@sgi.com> <20060829200304.GF1290@us.ibm.com> <20060829193828.d38395fe.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829193828.d38395fe.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 07:38:28PM -0700, Paul Jackson wrote:
> Paul E. McKenney wrote:
> > Let me throw something together...
> 
> I think it's the hotplug folks that were most interested
> in this "unfair rwsem" lock, for lock_cpu_hotplug().

Yep, been chatting with them separately.

> I wouldn't spend any effort on throwing this together
> just for cpusets.  I'm not looking to change cpuset
> locking anytime soon.

Well, my next question was going to be whether cpuset readers really
need to exclude the writers, or whether there can be a transition
period while the mastodon makes the change as long as it avoids stomping
the locusts.  ;-)

							Thanx, Paul
