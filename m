Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbSKGFfl>; Thu, 7 Nov 2002 00:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266378AbSKGFfl>; Thu, 7 Nov 2002 00:35:41 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:12341 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S266377AbSKGFfj>;
	Thu, 7 Nov 2002 00:35:39 -0500
Message-ID: <3DCA0BCC.3080203@mvista.com>
Date: Thu, 07 Nov 2002 00:44:28 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: NMI handling rework
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo et al...

Since a lot of things have started tying into the NMI handler (oprofile, 
nmi watchdog, memory errors, bus error, now the IPMI watchdog), I think 
it better to use a request/release mechanism for the NMI handlers. 
 Plus, I think the current NMI code is actually not correct, it's 
theoretically possible to miss NMIs if two occur at the same time.  So 
I'm proposing the patch at 
http://home.attbi.com/~minyard/linux-nmi-v8.diff, relative to current 
2.5.  This has been posted on lkml, and reviewed by John Levon and others.

Thanks,

-Corey

