Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWJAUYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWJAUYI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWJAUYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:24:08 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:49562 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932310AbWJAUYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:24:06 -0400
X-IronPort-AV: i="4.09,241,1157353200"; 
   d="scan'208"; a="327171145:sNHT50568108"
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Walker <dwalker@mvista.com>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: gcc bogus warning repository
X-Message-Flag: Warning: May contain useful information
References: <451FC657.6090603@garzik.org>
	<1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20061001111226.3e14133f.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 01 Oct 2006 13:24:04 -0700
In-Reply-To: <20061001111226.3e14133f.akpm@osdl.org> (Andrew Morton's message of "Sun, 1 Oct 2006 11:12:26 -0700")
Message-ID: <ada8xjzyecb.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Oct 2006 20:24:05.0432 (UTC) FILETIME=[8A928B80:01C6E597]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> The downsides are that it muckies up the source a little
    Andrew> and introduces a very small risk that real
    Andrew> use-uninitialised bugs will be hidden.  But I believe the
    Andrew> benefit outweighs those disadvantages.

Not sure I agree -- it adds one more thing that must be maintained
when reorganizing code.  I think there is a pretty high risk of this
sort of warning silencing hiding a bug introduced later, which would
have triggered an "is used uninitialized" warning.

Perhaps asking for a gcc flag that turns off "may be used" warnings
but leaves "is used" warnings would be useful (or does it already exist?)
