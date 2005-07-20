Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVGTVpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVGTVpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 17:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGTVpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 17:45:22 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:64435 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261509AbVGTVpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 17:45:20 -0400
Date: Wed, 20 Jul 2005 23:45:19 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Paul Jackson <pj@sgi.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, relayfs-devel@lists.sourceforge.net,
       richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, zanussi@us.ibm.com
Subject: Re: [PATCH] Re: relayfs documentation sucks?
Message-ID: <20050720214519.GA13155@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Paul Jackson <pj@sgi.com>, Steven Rostedt <rostedt@goodmis.org>,
	relayfs-devel@lists.sourceforge.net, richardj_moore@uk.ibm.com,
	varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
	zanussi@us.ibm.com
References: <17107.6290.734560.231978@tut.ibm.com> <20050716210759.GA1850@outpost.ds9a.nl> <17113.38067.551471.862551@tut.ibm.com> <20050717090137.GB5161@outpost.ds9a.nl> <17114.31916.451621.501383@tut.ibm.com> <20050717194558.GC27353@outpost.ds9a.nl> <1121693274.12862.15.camel@localhost.localdomain> <20050720142732.761354de.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050720142732.761354de.pj@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> When I'm debugging something requiring detailed tracing, I don't want
> to have to think about whether the tracing tool has the particular
> behaviour, performance, data loss, and other such characteristics
> needed for my immediate needs.  It is easier to code up some little
> ad hoc mechanism than it is to try to figure out whether some general
> purpose mechanism is suitable and how to use the generic mechanism.

You can do lots of modes with relayfs already - no ping-pong buffer,
n-buffer, lossy, not lossy etc etc.

I currently use it in 'flight-recorder' mode where new messages overwrite
old ones.

It might be good to document different possible ways of using relayfs.

> If there are enough specific purposes for relayfs, fine.  But beware
> of over generalizing its potential usefulness.  There is always the
> risk of over designing it, adding additional flexibility and options
> in an effort to gain customers, at the expense of making it less and
> less obviously useful in a trivial way for any specific purpose.

It's currently pretty limited - but you can add more features on top of it,
in a modular fashion. I tend not to use the complex stuff, but you can layer
it if you want.

It'd be nice if we had some basic relaying infrastructure available that'd
cover most needs successfully. Advanced users can do advanced things if they
want.

Btw, the diskstat tools (http://ds9a.nl/diskstat) require relayfs. It'll be
released this Friday or so.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
