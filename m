Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWAXVAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWAXVAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWAXVAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:00:04 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6045 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750704AbWAXVAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:00:00 -0500
In-Reply-To: <20060124160427.1ed68461.diegocg@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: a1426z@gawab.com, barryn@pobox.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, mloftis@wgops.com, nikita@clusterfs.com,
       Ram Gupta <ram.gupta5@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFB608064A.42CC9F1C-ON88257100.0072D92E-88257100.007356F8@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Tue, 24 Jan 2006 12:59:48 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/24/2006 15:59:58,
	Serialize complete at 01/24/2006 15:59:58
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Linux is the one desktop lacking something like this, both windows
>and max os x have things like this. I've wondered for long time if
>it's worth of it and if it could improve things in linux. The
>prefault part is easy once you get the data. The hard part is to get
>the statistics:

If you focus on the system startup speed problem, the stats are quite a 
bit simpler.  If you can take a snapshot of every mmap page in memory 
shortly after startup (and verify that no page frames were stolen during 
startup) and save that, you could just prefault all those pages in, in a 
single sweep, at the next boot.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems


