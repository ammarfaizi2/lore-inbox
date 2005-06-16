Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVFPUHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVFPUHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVFPUHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:07:20 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:37595 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261788AbVFPUHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:07:17 -0400
Message-ID: <42B1DBF1.4020904@nortel.com>
Date: Thu, 16 Jun 2005 14:07:13 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why does fsync() on a tmpfs directory give EINVAL?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The man page for fsync() suggests that it is necessary to call it on the 
directory fd.

However, in the case of tmpfs, fsync() on the file completes, but on the 
directory it returns -1 with errno==EINVAL.

Is there any particular reason for this?  Would a patch that makes it 
just return successfully without doing anything be accepted?

Chris
