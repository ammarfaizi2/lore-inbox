Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbSKMCoa>; Tue, 12 Nov 2002 21:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSKMCoa>; Tue, 12 Nov 2002 21:44:30 -0500
Received: from [203.117.131.12] ([203.117.131.12]:59585 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S267106AbSKMCo3>; Tue, 12 Nov 2002 21:44:29 -0500
Message-ID: <3DD1BE22.2010706@metaparadigm.com>
Date: Wed, 13 Nov 2002 10:51:14 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Brian Jackson <brian-kernel-list@mdrx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
References: <20021113002529.7413.qmail@escalade.vistahp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/02 08:25, Brian Jackson wrote:
> Here's a question for all those out there that are smarter than me(so I 
> guess that's most of you then :) I looked around (google, kernel source, 
> etc.) trying to find the answer, but came up with nothing.
> Does the MD driver work with shared storage? I would also be interested 
> to know if the new DM driver works with shared storage(though I must 
> admit I didn't really try to answer this one myself, just hoping 
> somebody will know).

They should work, obviously with some caveats. Having 2 hosts both
trying to reconstruct the same md RAID1 may cause some troubles.

> I ask because I seem to be having some strange problems with an md 
> device on shared storage(Qlogic FC controllers). The qlogic drivers spit 
> out messages for about 20-60 lines then the machines lock up. So the 
> drivers were my first suspicion, but they were working okay before. So I 
> went back and got rid of the md device and now everything is working 
> again. Anybody got any ideas?

Could be a stack related problem with the qlogic driver. The additional
stack pressure of the md layer perhaps ?? The 20-60 lines of logs in
would probably give some ideas.

I have a couple of shared storage clusters that were using qla2300
driver, ext3 and LVM1 and they would periodically ooops. Removed LVM
and the systems are now rock solid.

~mc

