Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTBKVFo>; Tue, 11 Feb 2003 16:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTBKVFF>; Tue, 11 Feb 2003 16:05:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8832
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266243AbTBKVE2>; Tue, 11 Feb 2003 16:04:28 -0500
Subject: Re: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.33.0302111241560.1173-100000@pcgl.dsa-ac.de>
References: <Pine.LNX.4.33.0302111241560.1173-100000@pcgl.dsa-ac.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044969981.12906.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Feb 2003 13:26:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 12:00, Guennadi Liakhovetski wrote:
> Hell
> 
> I reported earlier a problem with getting 2 flash disks to work in
> true-IDE mode with 2.4.[18|20]
> (http://www.uwsg.indiana.edu/hypermail/linux/kernel/0302.0/0918.html).
> Today I tried 2.5.60. Tried with 2 flash-disks and with 1 only. With 2
> flash-disks connected the kernel panics (notice, hda disappears after the
> initial detection):

Known problem. Its probably fixed in the 2.4 changes I made to the
probe and flash bits yesterday. Its two bugs together. The vanishing
disk is definitely fixed, the oops from drive->id = NULL should be
sorted too (and the general noprobe, cdrom cases)

Alan

