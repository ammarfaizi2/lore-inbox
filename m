Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUCSWEC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUCSWEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:04:02 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:40588 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263028AbUCSWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:03:58 -0500
Date: Fri, 19 Mar 2004 23:03:54 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040319220354.GB7161@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1079641026.2447.327.camel@abyss.local> <1079642001.11057.7.camel@watt.suse.com> <1079642801.2447.369.camel@abyss.local> <1079643740.11057.16.camel@watt.suse.com> <1079644190.2450.405.camel@abyss.local> <1079644743.11055.26.camel@watt.suse.com> <405AA9D9.40109@namesys.com> <1079704347.11057.130.camel@watt.suse.com> <405B4BA3.2030205@namesys.com> <1079726769.2446.233.camel@abyss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079726769.2446.233.camel@abyss.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Peter Zaitsev wrote:

> If file system would guaranty atomicity of write() calls (synchronous
> would be enough) we could disable it and get good extra performance.

Berkeley DB 4.2.52 for instance documents that page writes (of data base
pages) must be atomic, hence, if the data base page size is larger than
what the FS can write atomically, a crash may leave the data base in a
non-recoverable (catastrophic) state. (This assumes using the
write-ahead logging "Berkeley DB Transactional Data Store" mode of
operation, the other modes aren't recoveable after crash anyways.)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
