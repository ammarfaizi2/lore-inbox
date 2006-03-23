Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWCWPGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWCWPGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWCWPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:06:18 -0500
Received: from zipcon.net ([209.221.136.5]:1980 "HELO zipcon.net")
	by vger.kernel.org with SMTP id S932290AbWCWPGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:06:17 -0500
Message-ID: <4422B95D.9070900@beezmo.com>
Date: Thu, 23 Mar 2006 07:06:05 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFCLUE2] 64 bit driver 32 bit app ioctl
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for dashing this off without the proper homework.  My
customer is out of country doing an installation, and didn't test
this configuration first :(

Customer is running RHEL3 on a 64 bit PC.  Running the 64 bit kernel
and my 64 bit driver.  They are calling the driver from their 32 bit
app.  The driver supports a whole mess of ioctls.

It seems that the kernel is trapping the 32-bit ioctl call and returning
an error to the app w/out calling the driver.  It looks like
register_ioctl32_conversion() can convice the kernel that the driver can
handle 32-bit calls, but it has to be called for each ioctl cmd (??)

Putting aside (please) discussion of whether the kernel should presume
to hijack private ioctls, and whether I should be using the ioctl
interface at all (compatibility with app interface going back to 2.0
and SunOS) is there some way to make _one_ register call to indicate
that all my cmds are safe, or maybe an alternate ioctl entry point
that the  kernel won't trap?

Yours in desperation,
Bill

-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch

