Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbTAIIsk>; Thu, 9 Jan 2003 03:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTAIIsj>; Thu, 9 Jan 2003 03:48:39 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:11784
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262392AbTAIIsh>; Thu, 9 Jan 2003 03:48:37 -0500
Subject: Re: Gauntlet Set NOW!
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@digeo.com>
Cc: rms@gnu.org, andre@linux-ide.org, linux-kernel@vger.kernel.org
In-Reply-To: <3E1D2E12.27417587@digeo.com>
References: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org>
	 (message from Andre Hedrick on Fri, 3 Jan 2003 15:01:51 -0800 (PST)) <E18WX7P-0001cV-00@fencepost.gnu.org>
	 <3E1D2E12.27417587@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042102636.27634.115.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 00:57:16 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 00:08, Andrew Morton wrote:
> Richard Stallman wrote:
> > 
> > ...
> > That's not the FSF's view.  Our view is that just using structure
> > definitions, typedefs, enumeration constants, macros with simple
> > bodies, etc., is NOT enough to make a derivative work.  It would take
> > a substantial amount of code (coming from inline functions or macros
> > with substantial bodies) to do that.
> 
> The last part doesn't make a lot of sense.
> 
> Use of an inline function is just that: usage.  It matters not at
> all whether that function is invoked via inline integration or via
> subroutine call.  This is merely an implementation detail within
> the code which provides that function.
> 
> Such functions are part of the offered API which have global scope,
> that's all.

The thing that copyright law cares about is whether the thing you're
shipping (in binary form) is a derivative work of something else; the
GPL cares if that "something else" is licensed under the GPL because it
requires the whole to be also (at least) GPL'd.  Merely calling a
function from a piece of code doesn't make that code a derivative work
of the called function, but it would if the function were inlined.

If a non-GPL piece of code depends on a piece of GPL'd code, but they
are not shipped in a bound state (ie, dynamically linked), then the
non-GPL code is not obligated to be GPL'd because it isn't a derivative
work.  This isn't the stated position of the FSF (at least last time I
asked, because they don't consider static and dynamic binding to be
separate cases), but it's the only one which makes sense in terms of
looking at code in the binary and how it got there. 

There's a more complex argument that merely depending on GPL'd code (as
a client of a GPL'd library, for example) makes your program a
derivative work, even if your distributed binary contains no GPL'd
code.  This argument is based on the assumption that you're depending on
an API for which all the implementations are GPL'd, so there's no way
you can run the code without binding to GPL'd code.  All it takes is one
non-GPL'd implementation to break this argument.

Bear in mind that the GPL only governs the act of distribution, so
creating a derivative work dynamically at runtime is not subject to the
GPL.  Doing it statically means that you have to distribute the
derivative work, which is subject to the GPL.

Also bear in mind that copyright law only protects things with a
creative input; you cannot copyright pure facts.  As Richard says, the
FSF considers things like function names, types, structure definitions,
constants, etc to be pure facts which are necessary to know to call an
API (and extends that to include small pieces of code, where "small" is
not well defined).  The implementation of the API itself *is* creative,
and is therefore protected by copyright law.  Hence the distinction
between definitions and larger inlined implementations.

Since the thing that is under consideration is not source code, but the
distribution of binaries generated from the source, it is not merely an
implementation detail as to whether a piece of code is included by
reference (ie, an out-of-line function call) or included explicitly
(inlined code).  It makes the difference between a non-derivative work
and a derivative work.

	J

[Not a lawyer, but I've spent a lot of time talking to them about this
stuff.  Not that it makes this message at all valuable or reliable. ]

