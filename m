Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWAWWm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWAWWm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWAWWm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:42:27 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:32207 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1030200AbWAWWm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:42:26 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17365.23510.525066.57628@gargle.gargle.HOWL>
Date: Tue, 24 Jan 2006 01:42:30 +0300
To: Michael Loftis <mloftis@wgops.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Newsgroups: gmane.linux.file-systems,gmane.linux.kernel
In-Reply-To: <280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
References: <200601212108.41269.a1426z@gawab.com>
	<986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	<E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	<728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
	<280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis writes:
 > 
 > 
 > --On January 23, 2006 9:05:41 AM -0600 Ram Gupta <ram.gupta5@gmail.com> 
 > wrote:
 > 
 > >
 > > Linux also supports multiple swap files . But these are more
 > > beneficial if there are more than one disk in the system so that i/o
 > > can be done in parallel. These swap files may be activated at run time
 > > based on some criteria.
 > 
 > You missed the point.  The kernel in OS X maintains creation and use of 
 > these files automatically.  The point wasn't oh wow multiple files' it was 
 > that it creates them on the fly.  I just posted back with the apparent new 

This can be done in Linux from user-space: write a script that monitors
free swap space (grep SwapFree /proc/meminfo), and adds/removes new swap
files err... on-the-fly, or --even better-- just-in-time.

The unique feature that Mac OS X VM does have, on the other hand, is
that it keeps profiles of access patterns of applications, and stores
then in files, associated with executables. This allows to quickly
pre-fault necessary pages during application startup (and this makes OSX
boot so fast).

Nikita.
