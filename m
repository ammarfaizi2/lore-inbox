Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRCGUGN>; Wed, 7 Mar 2001 15:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbRCGUGD>; Wed, 7 Mar 2001 15:06:03 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:29271 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130013AbRCGUF4>;
	Wed, 7 Mar 2001 15:05:56 -0500
Message-ID: <3AA69414.80B10E6E@sgi.com>
Date: Wed, 07 Mar 2001 12:03:32 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: setfsuid
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why doesn't setfsuid return -EPERM when it can't perform the operation?
file: kernel/sys.c, 'sys_setfsuid' around line 779 depending on your
source version.

There is a check if capable(CAP_SETUID), that if it fails, doesn't
return an error.  This seems inconsistent.  In fact the manpage
I have on it states:

RETURN VALUE
       On success, the previous value of fsuid is  returned.   On
       error, the current value of fsuid is returned.
BUGS
       No error messages of any kind are returned to the  caller.
       At  the very least, EPERM should be returned when the call
       fails.

-l
-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
