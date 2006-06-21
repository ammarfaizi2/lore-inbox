Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWFUVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWFUVsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWFUVsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:48:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:23841 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030186AbWFUVsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:48:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=HDkEnBG3DHH/pjAAsSNj6ilLiinE9fm1I07gRPlsXoTvyNWsH3YzO4/h1pVdHtvn0vUtPsSbllS966hScAXo0czLG347NYBVlWxHQ8wmtvywTZjoCdPwFSGpYzhX/lrIPmV0zfHb02+cDOTK6OQ/jvtg8dxQfFmnShjRDIvo+5E=
Message-ID: <4499BE99.6010508@gmail.com>
Date: Wed, 21 Jun 2006 23:47:46 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       pingc@wacom.com
Subject: swsusp regression [Was: 2.6.17-mm1]
References: <20060621034857.35cfe36f.akpm@osdl.org>
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton napsal(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/

[32512.214000] Suspending device usbdev3.2_ep81
[32512.214040] Suspending device 3-2:1.0
[32512.214081] wacom 3-2:1.0: no suspend for driver wacom?
[32512.214128] Suspending device usbdev3.2_ep00
[32512.214169] Suspending device 3-2
[32512.214209] suspend_device(): usb_generic_suspend+0x0/0x128() returns -16
[32512.214319] Could not suspend device 3-2: error -16
[32512.214361] wacom 3-2:1.0: no resume for driver wacom?
[32512.242552] Some devices failed to suspend

Bus 003 Device 002: ID 056a:0011 Wacom Co., Ltd Graphire 2

Wacom messages are not new, but it now causes not suspending.

2.6.17-rc6-mm2 was OK.

Is there any more info needed?

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
