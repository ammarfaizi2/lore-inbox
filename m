Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUKSVzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUKSVzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUKSVyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:54:22 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:4277 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261606AbUKSVvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:51:42 -0500
Message-ID: <419E6AEA.3060207@nortelnetworks.com>
Date: Fri, 19 Nov 2004 15:51:38 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: question on accessing device nodes for drivers that are not loaded
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on 2.6.9.  I wrote a driver as a module that binds in as a misc char 
device.

I created the node for it manually, tested loading/unloading, running, etc.

Then I unloaded the driver, and tried running my little test app.  It appears to 
have hung on the call to open the device node (for which there was no driver 
loaded).  Top shows it in D state.  Then I went to load the driver module, and 
the insmod command hung with a refcount of 1.

Is this expected behaviour?

Chris
