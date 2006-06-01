Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWFAJo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWFAJo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFAJo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:44:57 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28369 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964785AbWFAJo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:44:56 -0400
Date: Thu, 1 Jun 2006 11:44:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Janos Haar <djani22@netcenter.hu>
cc: nathans@sgi.com, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS related hang (was Re: How to send a break? - dump from frozen
 64bit linux)
In-Reply-To: <00d901c6854d$1fc49230$1800a8c0@dcccs>
Message-ID: <Pine.LNX.4.61.0606011143410.3533@yvahk01.tjqt.qr>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home>
 <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com>
 <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs>
 <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu>
 <1149038431.21827.20.camel@localhost.localdomain>
 <20060531143849.C478554@wobbly.melbourne.sgi.com> <00f501c68488$4d10c080$1800a8c0@dcccs>
 <Pine.LNX.4.61.0605312353530.30170@yvahk01.tjqt.qr> <00d901c6854d$1fc49230$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Reinit:
>>
>> quotaoff /mntpt
>> umount /mntpt
>> mount /mntpt
>
>Thanks! :-)
>
Too bad XFS does not reinit quota on these commands:

qutoaoff /mp
quotaon /mp

Yes, it would lock the filesystem for a moment, but that's better than 
trying to unmount it under someone having inodes open!


Jan Engelhardt
-- 
