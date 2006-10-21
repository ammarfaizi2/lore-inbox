Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993118AbWJUSAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993118AbWJUSAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993138AbWJUSAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:00:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65438 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2993118AbWJUSAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:00:08 -0400
Date: Sat, 21 Oct 2006 14:00:05 -0400
From: Dave Jones <davej@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: futex hang with rpm in 2.6.17.1-2174_FC5
Message-ID: <20061021180005.GF30758@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Greear <greearb@candelatech.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <453917C2.8010201@candelatech.com> <20061021052423.GF21948@redhat.com> <453A5C9E.1070303@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453A5C9E.1070303@candelatech.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 10:45:02AM -0700, Ben Greear wrote:
 > Dave Jones wrote:
 > > On Fri, Oct 20, 2006 at 11:38:58AM -0700, Ben Greear wrote:
 > >  > I had a dead nfs server that was causing some programs to pause,
 > >  > in particular 'yum install foo' was paused.  I kill -9'd the
 > >  > yum related processes.
 > >  > 
 > > The dead rpm you killed left behind locks in its databases.
 > > rm -f /var/lib/rpm/__db* and it should work again.
 > >   
 > I'll give that a try, but shouldn't these locks clean themselves up when the
 > process is killed

If you kill -9'd the processes, what do you expect to do
the clean up work ?

 > or shouldn't rpm notice the previous process is dead and
 > clean it up itself?
 
Sounds sensible to me and you, but in the past sensible ideas and
rpm maintainers haven't gone hand in hand.

	Dave

-- 
http://www.codemonkey.org.uk
