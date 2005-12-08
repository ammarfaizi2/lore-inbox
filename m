Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVLHUgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVLHUgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLHUgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:36:22 -0500
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55]:37787 "EHLO
	zrtps0kn.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932304AbVLHUgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:36:21 -0500
Message-ID: <4398993E.9010200@nortel.com>
Date: Thu, 08 Dec 2005 14:36:14 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: problem with gate_vma flags?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2005 20:36:16.0165 (UTC) FILETIME=[096FCD50:01C5FC37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When viewing /proc/<pid>/maps on i386, the final page shows up as :

ffffe000-fffff000 ---p 00000000 00:00 0

If I'm reading the code correctly, this is the address range controlled 
by gate_vma.

The permissions are marked as nothing because when this vma is created 
"vm_flags" is set to 0.  However, shouldn't it be at least VM_READ and 
possibly also VM_EXEC?

Chris

