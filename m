Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVAGPvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVAGPvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVAGPvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:51:07 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:34775 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261470AbVAGPvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:51:02 -0500
Message-ID: <41DEAFE2.1030001@nortelnetworks.com>
Date: Fri, 07 Jan 2005 09:50:58 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: where to put kernel code to run on exec?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've added a field to the task struct to keep track of whether or not 
the process wants to be notified of various events.  On exec() I'd like 
to clear this field.

I'm having problems finding a nice clean place to put the code to clear 
it.  The obvious choice would be in the last bit of the success path in 
do_execve(), but there's nothing similar there already, so I'm probably 
missing something.

Is there some standard place to put code to run on a successful call to 
exec()?

Chris

Chris
