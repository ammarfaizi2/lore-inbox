Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTDTRfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTDTRfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:35:42 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:61242 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263646AbTDTRfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:35:41 -0400
Date: Sun, 20 Apr 2003 13:44:35 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: "arjanv@redhat.com" <arjanv@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304201347_MC3-1-353A-3A32@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> You will if it writes and fails to read back. The disk can't invent a
>> sector that is gone. 
>
> but linux can if you use an raid1 mirror... maybe we should teach the md
> layer to write back the data from the other disk on a "bad sector"
> error.


  NTFS does this in the filesystem by moving the affected cluster
somewhere else, then marking it bad in its allocation map.  Of course
in order to do that it has to get notifications from the ft disk
driver...


------
 Chuck
