Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVBOVdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVBOVdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVBOVdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:33:09 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:53911 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261902AbVBOVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:32:51 -0500
Message-ID: <42126A58.6050608@nortel.com>
Date: Tue, 15 Feb 2005 15:32:08 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, prakashp@arcor.de,
       paolo.ciarrocchi@gmail.com, gregkh@suse.de, pmcfarland@downeast.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
References: <20050211004033.GA26624@suse.de>	<420C054B.1070502@downeast.net>	<20050211011609.GA27176@suse.de>	<1108354011.25912.43.camel@krustophenia.net>	<4d8e3fd305021400323fa01fff@mail.gmail.com>	<42106685.40307@arcor.de>	<1108422240.28902.11.camel@krustophenia.net>	<20050215004329.5b96b5a1.diegocg@gmail.com>	<1108497066.7826.33.camel@krustophenia.net> <20050215220254.511a6001.diegocg@gmail.com>
In-Reply-To: <20050215220254.511a6001.diegocg@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> Of course there're lots of problems, like what happens
> if you change a file which was being used by a suspended process, 

That one is easy.  Store a checksum of the file in use when you go to 
sleep  If on wakeup the checksum is different, pop up a window that says 
"the file *foo* has been modified by another application, do you want to 
reload?".

 > what happens if you update a library that a image is supposed to
> use

Same as updating it on a running system.  Don't do that unless you 
really know what you're doing.

Chris
