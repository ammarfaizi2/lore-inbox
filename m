Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbUKUKTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbUKUKTa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUKUKTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:19:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7808 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261288AbUKUKT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:19:27 -0500
Date: Sun, 21 Nov 2004 11:19:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Blaisorblade <blaisorblade_spam@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why INSTALL_PATH is not /boot by default?
In-Reply-To: <20041121094308.GA7911@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.53.0411211115530.4205@yvahk01.tjqt.qr>
References: <200411160127.15471.blaisorblade_spam@yahoo.it>
 <20041121094308.GA7911@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This line, in the main Makefile, is commented:
>>
>> export  INSTALL_PATH=/boot
>>
>> Why? It seems pointless, since almost everything has been for ages requiring
>> this settings, and distros' versions of installkernel have been taking an
>> empty INSTALL_PATH as meaning /boot for ages (for instance Mandrake). It's
>> maybe even mandated by the FHS (dunno).

FHS says that the kernel image can be in either / or /boot. However, older 386'
require that extra partition below 1024 cyls.
Plus, I am of the opinion that there should not be any files in /
(incircumventable exception are quota files); ls -l already shows 57 entries
for this machine's root dir.

>If /boot is ok for other than just i386 we can give it a try.

boot is always ok given that you copy the kernel from the source tree to <your
favorite destination> by hand.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
