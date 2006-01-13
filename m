Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422932AbWAMUeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbWAMUeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422934AbWAMUeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:34:18 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:48363 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1422932AbWAMUeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:34:18 -0500
Date: Fri, 13 Jan 2006 12:34:15 -0800
From: Paul Jackson <pj@sgi.com>
To: Ben Greear <greearb@candelatech.com>
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: Compile error with 2.6.15
Message-Id: <20060113123415.932b4a80.pj@sgi.com>
In-Reply-To: <43C76104.5090607@candelatech.com>
References: <43C75D2A.2050405@candelatech.com>
	<43C76104.5090607@candelatech.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Guess it is probably not a real problem...

Or, it's probably a real problem.  The asm-offsets.h file
has a long history of being a thorn in the side of Makefiles,
including race conditions (such as you saw with -j4).  There
is a natural circular dependency in the construction of the
asm-offsets.h file and the rest of the build that's tricky
to get right.

Whether or not someone sees enough evidence yet to deal with
this instance of that breakage ... that's another matter.

Often this kind of breakage remains until someone with the
right mental weapons gets bit by it, and goes hunting it down.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
