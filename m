Return-Path: <linux-kernel-owner+w=401wt.eu-S1751417AbWLRRsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWLRRsO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 12:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWLRRsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 12:48:14 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:11212 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbWLRRsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 12:48:13 -0500
Message-ID: <4586D4A4.5060309@oracle.com>
Date: Mon, 18 Dec 2006 09:49:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: gregkh <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       kay.sievers@vrfy.org
Subject: kobject.h with HOTPLUG=n
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.20-rc1-mm1, with HOTPLUG=n, 2 linux/kobject.h inline functions
need to return <int>.  Currently this causes 962 warnings like this:

include/linux/kobject.h: In function 'kobject_uevent':
include/linux/kobject.h:277: warning: no return statement in function returning non-void
include/linux/kobject.h: In function 'kobject_uevent_env':
include/linux/kobject.h:281: warning: no return statement in function returning non-void

Should these functions return 0 or some error code?

static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
static inline int kobject_uevent_env(struct kobject *kobj,
				      enum kobject_action action,
				      char *envp[])
{ }

-- 
~Randy
