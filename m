Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266579AbUBDUeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUBDUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:32:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:14823 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266576AbUBDUam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:30:42 -0500
Subject: Re: [Bug 2013] New: Oops from create_dir (sysfs)
From: John Rose <johnrose@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: greg KH <gregkh@us.ibm.com>
Content-Type: text/plain
Message-Id: <1075926442.3026.37.camel@verve>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 14:27:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last couple of weeks, I've come across this crash a few times. 
In each case, my code was kobject_add()'ing a kobject to a kset that
already contained a kobject of the same name.

Granted that these additions reflected faulty logic on the part of my
code, but I was suprised that kobject_add didn't have a more intelligent
response than crashing while creating the redundant sysfs dir.

Thoughts?
John

http://bugme.osdl.org/show_bug.cgi?id=2013
-- 
John Rose <johnrose@austin.ibm.com>

