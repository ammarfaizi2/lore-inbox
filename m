Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbTCNJz2>; Fri, 14 Mar 2003 04:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbTCNJz2>; Fri, 14 Mar 2003 04:55:28 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:60682
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262835AbTCNJzZ>; Fri, 14 Mar 2003 04:55:25 -0500
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030314104219.GA791@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org>
	 <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org>
	 <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org>
	 <20030314104219.GA791@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1047636371.1147.8.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Mar 2003 02:06:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 02:42, Jens Axboe wrote:
> Looks much better. Somehow the 'random' rpm you had didn't do SG_IO,
> odd.

It was the PLD cdrtools-2.01a05-1.i386.rpm; it is the same source I
built from, though it was looking in /usr/include/linux for headers, and
I changed my build to go to /lib/modules/`uname -r`/build/include.

> > though I don't seem to be able to set up a default device in
> > /etc/cdrecord.conf.
> 
> I have no idea how that works. What do you typicall do?

I worked it out.  The source out of the box looks in
/etc/default/cdrecord; most distros change that to /etc/cdrecord.conf.

	J

