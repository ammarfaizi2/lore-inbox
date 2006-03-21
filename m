Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWCURnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWCURnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWCURnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:43:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30651 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751264AbWCURng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:43:36 -0500
Date: Tue, 21 Mar 2006 18:43:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
In-Reply-To: <200603210849.20224.yarick@it-territory.ru>
Message-ID: <Pine.LNX.4.61.0603211842070.21376@yvahk01.tjqt.qr>
References: <1142890822.5007.18.camel@localhost.localdomain>
 <Pine.LNX.4.61.0603202244370.11933@yvahk01.tjqt.qr> <200603210849.20224.yarick@it-territory.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It seems only fair to me to not allow creating these files under Linux 
>> either, to avoid problems when booting back to Dos/Windows.
>
>This is true. smbfs, OTOH, has no such checks, so creating aux.h on an smb share is one easy way to DoS 
>all WinXP machines using(browsing) this share. Explorer hangs on reading directory with this file.

BTW, what about cifs? And after all, this is not a smbfs check,
but it is something that should be done on the server side.
If you use smbfs to connect two Linux machines, you should be
able to create all the weird names you can imagine (with respect
to what the smb protocol allows). If you have a Windows machine
as the smbfs server, creating 'special files' should be limited
by whatever Windows sees fit.



Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
