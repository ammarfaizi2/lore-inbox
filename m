Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUDVAIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUDVAIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUDVAIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 20:08:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41138 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262802AbUDVAIr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 20:08:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: ext3 reservation question.
Date: Wed, 21 Apr 2004 16:55:47 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200404211655.47329.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I was just wondering, what would make sense..

Lets say I have a "goal" for allocation, but the goal is not inside my 
reservation window. Is it worth *try* to satisfy the goal by throwing
out our window ? Or should we ignore goal and allocate from the
current reservation window ?

And also, how does ext3 determines the goal ?

I am worried about a case, where multiple threads writing to 
different parts of same file - there by each thread thrashing 
reservation window (since each one has its own goal).

BTW, the current reservation code honors "goal" and throws our
window and tries to get a new one to satisfy the goal.

Thanks,
Badari

