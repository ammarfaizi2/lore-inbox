Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSLIQTx>; Mon, 9 Dec 2002 11:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSLIQTw>; Mon, 9 Dec 2002 11:19:52 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:16908
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S265754AbSLIQTw>; Mon, 9 Dec 2002 11:19:52 -0500
Subject: Re: Detecting threads vs processes with ps or /proc
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Robert Love <rml@tech9.net>
Cc: Nick LeRoy <nleroy@cs.wisc.edu>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039205353.1943.2191.camel@phantasy>
References: <200212060924.02162.nleroy@cs.wisc.edu>
	 <1039204112.1943.2142.camel@phantasy>
	 <200212061356.16022.nleroy@cs.wisc.edu>
	 <1039205353.1943.2191.camel@phantasy>
Content-Type: text/plain
Organization: 
Message-Id: <1039451252.5905.866.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Dec 2002 08:27:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 12:09, Robert Love wrote:
> One thing to note: if you can modify the kernel and procps, you can just
> export the value of task->mm out of /proc.  It is a gross hack, and
> perhaps a security issue, but that will work 100%.  Same ->mm implies
> thread.

It isn't a terribly gross hack.  I have a patch (somewhere...) which
adds an ASID: field to /proc/<pid>/status, which simply contains the mm
pointer (as an opaque identifier token).  If you were worried about
exposing (yet another) kernel pointer value, I suppose you could mush it
about a bit, but I think that would give the illusion of obscurity
rather than any actual increase in security.

	J

