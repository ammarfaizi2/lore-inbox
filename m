Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbTCQQpf>; Mon, 17 Mar 2003 11:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbTCQQpf>; Mon, 17 Mar 2003 11:45:35 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:16146
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S261771AbTCQQpe>; Mon, 17 Mar 2003 11:45:34 -0500
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030317080522.GE791@suse.de>
References: <20030313190247.GQ836@suse.de>
	 <1047633884.1147.3.camel@ixodes.goop.org> <20030314104219.GA791@suse.de>
	 <1047637870.1147.27.camel@ixodes.goop.org> <20030314113732.GC791@suse.de>
	 <1047664774.25536.47.camel@ixodes.goop.org> <20030314180716.GZ791@suse.de>
	 <1047680345.1508.2.camel@ixodes.goop.org> <20030315081558.GK791@suse.de>
	 <1047783292.1209.3.camel@ixodes.goop.org>  <20030317080522.GE791@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1047920186.1246.32.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Mar 2003 08:56:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 00:05, Jens Axboe wrote:
> On Sat, Mar 15 2003, Jeremy Fitzhardinge wrote:
> > On Sat, 2003-03-15 at 00:15, Jens Axboe wrote:
> > > I can reliably crash the box with SG_IO -> ide-cd here, so I'm hoping
> > > there's a connection. Need to move it to a box where nmi watchdog
> > > actually works...
> > 
> > And wouldn't you know it - with -mm7 it seems to be working fine...
>                                        ^^
> What is 'it'?

Sorry: I meant "cdrecord dev=/dev/hdc -checkdrive" returns correct
"supported modes".

I was wrong, however: it is still broken.  Sometimes it will return
version 2/format 2 results time after time (with supported modes), but
then I leave it for a while and it reverts to returning 0/1 results with
no supported modes.  There doesn't seem to be any rhyme or reason about
it: the "put a disc in and it works" trick doesn't work any more.

This is with 2.5.64-mm8.  What other details would help?  strace output
of cdrecord?

	J

