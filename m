Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUKBULk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUKBULk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUKBULi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:11:38 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:57233 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261812AbUKBUIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:08:05 -0500
Message-ID: <4187E920.1070302@nortelnetworks.com>
Date: Tue, 02 Nov 2004 14:08:00 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: question on common error-handling idiom
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's something I've been wondering about for a while.  There is a lot of code 
in linux that looks something like this:


err = -ERRORCODE
if (error condition)
	goto out;


While nice to read, it would seem that it might be more efficient to do the 
following:

if (error condition) {
	err = -ERRORCODE;
	goto out;
}


Is there any particular reason why the former is preferred?  Is the compiler 
smart enough to optimize away the additional write in the non-error path?

Chris
