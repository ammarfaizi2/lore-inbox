Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292598AbSBUAfK>; Wed, 20 Feb 2002 19:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292600AbSBUAfB>; Wed, 20 Feb 2002 19:35:01 -0500
Received: from air-2.osdl.org ([65.201.151.6]:7435 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292598AbSBUAez>;
	Wed, 20 Feb 2002 19:34:55 -0500
Date: Wed, 20 Feb 2002 16:29:26 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Keith Owens <kaos@ocs.com.au>
cc: Jesse Barnes <jbarnes@sgi.com>, David Mosberger <davidm@hpl.hp.com>,
        Dan Maas <dmaas@dcine.com>, <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers 
In-Reply-To: <13997.1014156337@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33L2.0202201627270.3312-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Keith Owens wrote:

| On Tue, 19 Feb 2002 10:35:06 -0800,
| Jesse Barnes <jbarnes@sgi.com> wrote:
| >Making a variable volatile doesn't guarantee that the compiler won't
| >reorder references to it, AFAIK.  And on some platforms, even uncached
| >I/O references aren't necessarily ordered.
|
| Ignoring the issue of hardware that reorders I/O, volatile accesses
| must not be reordered by the compiler.  From a C9X draft (1999, anybody
| have the current C standard online?) :-
PDF file, for about US$18 - US$20, downloaded from ISO.

|   5.1.2.3 [#2]
|
|   Accessing  a volatile object, modifying an object, modifying a file,
|   or calling a function that does any of those operations are all side
|   effects which are changes in the state of the execution environment.
|   Evaluation of an expression may produce side effects.  At certain
|   specified points in the execution sequence called sequence points,
|   all side effects of previous evaluations shall be complete and no
|   side effects of subsequent evaluations shall have taken place.
No changes here.

|   5.1.2.3 [#6]
|
|   The least requirements on a conforming implementation are:
|
|     -- At sequence points, volatile objects are stable in the sense
|        that previous accesses are complete and subsequent accesses have
|        not yet occurred.
Same text, although it's #5 now.

| The compiler may not reorder volatile accesses across sequence points.
|
| volatile int *a, *b;
| int c;
|
| c = *a + *b;	// no sequence point, access order to a, b is undefined
|
| c = *a;		// compiler must not convert to the above format, it
| c += *b;	// must access a then b
|
|
| -

---
~Randy


