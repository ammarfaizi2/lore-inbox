Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVGNQ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVGNQ2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGNQ1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:27:02 -0400
Received: from fmr18.intel.com ([134.134.136.17]:57800 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262198AbVGNQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:25:16 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: linux-kernel@vger.kernel.org
Subject: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Date: Thu, 14 Jul 2005 09:12:22 -0700
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507140912.22532.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this is a broken record, but the development process within the LKML 
isn't resulting in more stable and better code.  Some process change could be 
a good thing.

Why does my alps mouse pad have to stop working every time I test a new 
"STABLE" kernel?  

Why does swsup have to start hanging on shut and startup down randomly?

I rolled back my home box with 2.6.10 because I want some stability (2.6.10 
has problems with swsusp from time to time, but it livable for me, for now.)

The process is broken if on a stable series we cannot at least make sure 
obvious regressions don't smack users between the eyes.

I see the problem as that too much code flux is happening from people without 
the resources, or discipline, to effectively regresion test for side effects 
of their changes.  

I know there is a lot of back patting on how well the dot-dot stability 
release process is working, but that process is a solution for a different 
and simpler problem and we still have breakage.

Stability and deliberate feature design and development along with disciplined 
regression testing and validation is what is needed.  Why can't there be more 
targeted and planned development?  Are we in a race to see how many changes 
we can push into a "stable" tree?

Shouldn't changes be regression tested, formally, before its allowed to go 
into a tree? 

Why can't I expect SWSusp work better and more reliable from release to 
release?  

I know there is a point where software goes from fun to work, but without more 
deliberate and disciplined WORK I see the 2.6 tree spinning out of control.

The problem is the process, not than the code.
* The issues are too much ad-hock code flux without enough disciplined/formal 
regression testing and review.  
* Small regressions are accepted and expected to be cached latter.
* ad-hock validation before changes are accepted.

Some possible things that could help:

*Addopt a no-regressions-allowed policy and everthing stops until any 
identified regressions (in performance, functionally or stability) is fixed 
or the changes are all rolled back.  This works really well if in addition 
organized pre-flight testing is done before calling a new version number.  
You simply cannot rely on ad-hock regression testing and reporting.  Its got 
too much latency.
* assign validation folks that the developer need to appease before changes 
are allowed to be accepted into the tree. 
* Make all changes to the kernel not be submitted by the developers, but by 
designated subsystem validation owners.  If too many bugs continue to sneak 
by address the problem by adding validation help to that subsystem or get a 
new owner for the problem subsystem.  (<-- I like this one a lot.)
* start 2.7 
* all of the above (<--this one is good too)

--mgross
BTW: This may or may not be the opinion of my employer, more likely not.

