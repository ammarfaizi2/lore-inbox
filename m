Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUDOStH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbUDOSq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:46:27 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:36022 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263089AbUDOSmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:42:45 -0400
Date: Thu, 15 Apr 2004 13:42:09 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <184380000.1082054529@[10.1.1.4]>
In-Reply-To: <Pine.LNX.4.44.0404151842530.9612-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404151842530.9612-100000@localhost.localdomain>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, April 15, 2004 18:50:42 +0100 Hugh Dickins
<hugh@veritas.com> wrote:

> Though I have to admit I'm sceptical: prio_tree appears to be well
> designed for the issue in question, list-of-lists sounds, well,
> no offence, but a bit of a hack.

It is a bit of a hack, but the theory behind it is fairly simple.  It came
out of my early efforts to sort the list. Martin and I produced a theory
that many vmas have identical start and end addresses due to fork and/or
fixed address mappings.  If this theory is true list-of-lists will create a
much shorter top-level list of unique start-end pairs for searching.  We'd
only need to walk the second level list when we get a match to the search.

It never got any serious exposure or testing.  It came out just as
everyone's attention shifted away from objrmap so no one really looked at
it.

Dave McCracken

