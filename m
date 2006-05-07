Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWEGKyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWEGKyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWEGKyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 06:54:20 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:10708 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932126AbWEGKyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 06:54:19 -0400
Date: Sun, 7 May 2006 12:54:09 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Jason Schoonover <jasons@pioneer-pra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060507105409.GA3835@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Jason Schoonover <jasons@pioneer-pra.com>,
	linux-kernel@vger.kernel.org
References: <200605051010.19725.jasons@pioneer-pra.com> <20060506230320.GA3463@outpost.ds9a.nl> <200605061802.47261.jasons@pioneer-pra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605061802.47261.jasons@pioneer-pra.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 06:02:47PM -0700, Jason Schoonover wrote:

> The interesting thing was that after I did a Ctrl-C on the ncftpget, the id 
> column was still at 0, even though the ncftpget process was over.  The id 
> column was at 0 and the 'wa' column was at 98, up until all of the pdflush 
> processes ended.
> 
> Is that the expected behavior?

Yes - data is still being written out. 'wa' stands for waiting for io. As
long as 'us' and 'sy' are not 100 (together), your system ('computing
power') is not 'busy'.

The lines below are perfect:
>  0  2     40  47816   7888 1920116    0    0     0 36264 1354    56  0  1  0 99
>  0  2     40  48312   7888 1920116    0    0     0 36248 1362    52  0  1  0 99

Wether you should have 5 pdflushes running is something I have no relevant
experience about, but your system should function just fine during writeout.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
