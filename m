Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTDMWGI (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbTDMWGI (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:06:08 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:5057 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262423AbTDMWGG (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 18:06:06 -0400
Date: Sun, 13 Apr 2003 18:13:24 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Quick question about hyper-threading
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304131817_MC3-1-3444-7E30@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rovert Love wrote:


> No, the current scheduler (HT or stock 2.5) does not do
> this.
>
> Your theories are correct.  It would be interesting to try
> this and see.
>
> It is nontrivial to do the ->mm checks in the scheduler though -
> certainly they cannot be done easily (if at all) in constant-time
> (i.e., it won't be O(1)).


  Is the scheduler even the right place to do that?

  I was thinking maybe the task_struct could use a cpus_desired
field -- then other parts of the system could give the scheduler hints
about which CPU to schedule a task on.

  
--
 Chuck
