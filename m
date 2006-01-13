Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422984AbWAMVZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWAMVZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422986AbWAMVZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:25:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31714 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422984AbWAMVZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:25:23 -0500
Date: Fri, 13 Jan 2006 15:25:06 -0600 (CST)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Robin Holt <holt@sgi.com>, ak@suse.de, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Add tmpfs options for memory placement policies (Resend
 with corrected addresses).
In-Reply-To: <20060113122349.5c367e05.akpm@osdl.org>
Message-ID: <20060113152228.W18980@chenjesu.americas.sgi.com>
References: <20060113160406.GE19156@lnx-holt.americas.sgi.com>
 <20060113162119.GF19156@lnx-holt.americas.sgi.com> <20060113122349.5c367e05.akpm@osdl.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Andrew Morton wrote:

> Confused.  Is this for applications which cannot be taught to use the
> mempolicy API?

In general yes.  Anything that writes into a tmpfs filesystem is liable
to disproportionately decrease the available memory on a particular node.
Since there's no telling what sort of application (e.g. dd/cp/cat) might be
dropping large files there, this lets the admin choose the appropriate
default behavior for their site's situation.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
