Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWHARDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWHARDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWHARDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:03:10 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:42707 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751661AbWHARDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:03:09 -0400
Message-ID: <44CF8949.707@slaphack.com>
Date: Tue, 01 Aug 2006 12:03:05 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, David Lang <dlang@digitalinsight.com>,
       David Masover <ninja@slaphack.com>, tdwebste2@yahoo.com,
       Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"expressed
 by kernelnewbies.org regarding reiser4 inclusion]
References: <20060801034726.58097.qmail@web51311.mail.yahoo.com> <44CED777.5080308@slaphack.com> <Pine.LNX.4.63.0607312133080.15179@qynat.qvtvafvgr.pbz> <20060801064837.GB1987@thunk.org>
In-Reply-To: <20060801064837.GB1987@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:

> Ah, but as soon as the repacker thread runs continuously, then you
> lose all or most of the claimed advantage of "wandering logs".
[...]
> So instead of a write-write overhead, you end up with a
> write-read-write overhead.

This would tend to suggest that the repacker should not run constantly, 
but also that while it's running, performance could be almost as good as 
ext3.

> But of course, people tend to disable the repacker when doing
> benchmarks because they're trying to play the "my filesystem/database
> has bigger performance numbers than yours" game....

So you run your own benchmarks, I'll run mine...  Benchmarks for 
everyone!  I'd especially like to see what performance is like with the 
repacker not running, and during the repack.  If performance during a 
repack is comparable to ext3, I think we win, although we have to amend 
that statement to "My filesystem/database has the same or bigger 
perfomance numbers than yours."
