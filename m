Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbTILTvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTILTvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:51:55 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:30591 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261818AbTILTvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:51:54 -0400
Date: Fri, 12 Sep 2003 12:51:52 -0700
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912195152.GA1353@sgi.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030911192550.7dfaf08c.ak@suse.de.suse.lists.linux.kernel> <1063308053.4430.37.camel@huykhoi.suse.lists.linux.kernel> <20030912162713.GA4852@sgi.com.suse.lists.linux.kernel> <20030912174807.GA629@sgi.com.suse.lists.linux.kernel> <p73y8wtlwf0.fsf@oldwotan.suse.de> <20030912111148.A15308@hockin.org> <20030912182430.GA1043@sgi.com> <223220000.1063393087@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223220000.1063393087@flay>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 11:58:07AM -0700, Martin J. Bligh wrote:
> >> Also - a perhaps more useful test is a write followed by a read.
> > 
> > Well, someone else will have to run that test.  On Altix, a read() is
> > freakishly expensive, and I'm not really interested in showing everyone
> > how bad it is ;)
> 
> I find percentile comparisons useful for hiding the embarassement
> of occasional hardware realities ;-) (ie what's the speed *ratio*
> between the two types of read).

Well, in our case, read() and in() will be pretty close,
percentage-wise.  The read() in itself is so bad that I think the
additional badness of in() will be mostly hidden.

Jesse
