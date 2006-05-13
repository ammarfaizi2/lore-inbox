Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWEMRrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWEMRrX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWEMRrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:47:23 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:55062 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932127AbWEMRrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:47:22 -0400
X-IronPort-AV: i="4.05,125,1146466800"; 
   d="scan'208"; a="1805711963:sNHT28783796"
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
X-Message-Flag: Warning: May contain useful information
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	<20060513160541.8848.2113.stgit@localhost.localdomain>
	<9a8748490605131042w3214a7b8lb9a862798e3131d4@mail.gmail.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 13 May 2006 10:47:18 -0700
In-Reply-To: <9a8748490605131042w3214a7b8lb9a862798e3131d4@mail.gmail.com> (Jesper Juhl's message of "Sat, 13 May 2006 19:42:40 +0200")
Message-ID: <ada7j4px1eh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 May 2006 17:47:21.0188 (UTC) FILETIME=[48F60A40:01C676B5]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jesper> /proc is such a mess already, do we have to add another
    Jesper> file to it?  How about using sysfs instead? I know that is
    Jesper> "one value pr file", but then simply make one file pr
    Jesper> leaked pointer or something like that...

Actually debugfs would make the most sense I think -- and the code
to create a debugfs file is simpler than the corresponding procfs code.

 - R.
