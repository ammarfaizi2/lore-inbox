Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWEJXG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWEJXG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWEJXG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:06:56 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:38980 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965065AbWEJXGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:06:54 -0400
X-IronPort-AV: i="4.05,111,1146466800"; 
   d="scan'208"; a="274800609:sNHT33812900"
To: "David S. Miller" <davem@davemloft.net>
Cc: viro@ftp.linux.org.uk, akpm@osdl.org, dwalker@mvista.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
X-Message-Flag: Warning: May contain useful information
References: <20060510162106.GC27946@ftp.linux.org.uk>
	<20060510150321.11262b24.akpm@osdl.org>
	<20060510221024.GH27946@ftp.linux.org.uk>
	<20060510.153129.122741274.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 May 2006 16:06:51 -0700
In-Reply-To: <20060510.153129.122741274.davem@davemloft.net> (David S. Miller's message of "Wed, 10 May 2006 15:31:29 -0700 (PDT)")
Message-ID: <adaody55vjo.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 May 2006 23:06:52.0079 (UTC) FILETIME=[6C769BF0:01C67486]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> IMHO, the tree should build with -Werror without exception.
    David> Once you have that basis, new ones will not show up easily
    David> and the hard part of the battle has been won.

It's a great goal, but which gcc version and architecture do you
declare has to build the kernel with -Werror?  Every gcc version and
platform produces a different set of warnings.  And what do you do
when all released versions of gcc produce a false positive warning?

The problem is that fixing false positive warnings often leads people
to write unnatural code that may hide future bugs (and in fact may be
buggy even when written).

 - R.
