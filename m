Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWAYXYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWAYXYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWAYXYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:24:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2187 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932219AbWAYXYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:24:07 -0500
Subject: Re: [RFC] VM: I have a dream...
From: Lee Revell <rlrevell@joe-job.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060125150243.GA8490@mail.shareable.org>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
	 <1138181033.4800.4.camel@tara.firmix.at> <1138182179.3087.1.camel@mindpipe>
	 <20060125150243.GA8490@mail.shareable.org>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 18:24:05 -0500
Message-Id: <1138231446.3087.61.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 15:02 +0000, Jamie Lokier wrote:
> Lee Revell wrote:
> > On Wed, 2006-01-25 at 10:23 +0100, Bernd Petrovitsch wrote:
> > > 
> > > ACK. X, evolution and Mozilla family (to name standard apps) are the
> > > exceptions to this rule. 
> > 
> > If you decrease RLIMIT_STACK from the default 8MB to 256KB or 512KB you
> > will reduce the footprint of multithreaded apps like evolution by tens
> > or hundreds of MB, as glibc sets the thread stack size to RLIMIT_STACK
> > by default.
> 
> That should make no difference to the real memory usage.  Stack pages
> which aren't used don't take up RAM, and don't count in RSS.

It still seems like not allocating memory that the application will
never use could enable the VM to make better decisions.  Also not
wasting 7.5MB per thread for the stack should make tracking down actual
bloat in the libraries easier.

Lee

