Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTDTQzA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTDTQy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:54:59 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:61399 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263631AbTDTQy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:54:59 -0400
Date: Sun, 20 Apr 2003 13:03:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: "arjanv@redhat.com" <arjanv@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304201306_MC3-1-3537-115@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan wrote:


>> You will if it writes and fails to read back. The disk can't invent a
>> sector that is gone. 
>
> but linux can if you use an raid1 mirror... maybe we should teach the md
> layer to write back the data from the other disk on a "bad sector"
> error.


  I have some ugly code that forces all reads from a mirror set to
a specific copy, set via a global sysctl.  This lets you do things
like make a backup from disk 0, then verify against disk 1 and take
action if something is wrong.


------
 Chuck
