Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTDTRfe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTDTRfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:35:33 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:62858 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263645AbTDTRfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:35:33 -0400
Date: Sun, 20 Apr 2003 13:44:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304201347_MC3-1-353A-3A31@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>   I have some ugly code that forces all reads from a mirror set to
>> a specific copy, set via a global sysctl.  This lets you do things
>> like make a backup from disk 0, then verify against disk 1 and take
>> action if something is wrong.
>
> That's interesting.  Have you thought of making it read from _both_
> disks and check that the data matches, before passing it back?


  It didn't seem to be worth doing, since a userspace program could
be written to do the same thing using my small patch.  Only problem
is, it uses a global sysctl that affects every mirror set in the machine,
so it could affect performance of every mirror if used during load.


------
 Chuck
