Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263569AbTCUJiC>; Fri, 21 Mar 2003 04:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263570AbTCUJiC>; Fri, 21 Mar 2003 04:38:02 -0500
Received: from mailhost1-chcgil.chcgil.ameritech.net ([206.141.192.67]:62157
	"EHLO mailhost.chi1.ameritech.net") by vger.kernel.org with ESMTP
	id <S263569AbTCUJiC>; Fri, 21 Mar 2003 04:38:02 -0500
Date: Fri, 21 Mar 2003 03:51:39 -0600
From: Mark J Roberts <mjr@znex.org>
To: linux-kernel@vger.kernel.org
Subject: Arbitrary mlock() half-memory limit.
Message-ID: <20030321095139.GB1324@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	/* we may lock at most half of physical memory... */
	/* (this check is pretty bogus, but doesn't hurt) */
	if (locked > num_physpages/2)
		goto out;

I've been running fluidsynth (a synthesizer program) with 700-900MB
instrument sample files on a box with 1GB of memory. It tries to
lock the samples into memory and fails.

This isn't a problem for me, since I don't have swap configured and
the sample data is anonymous-backed, but it's a case in which the
arbitrary limit is clearly pernicious.
