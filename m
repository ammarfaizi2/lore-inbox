Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTECCMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 22:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbTECCMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 22:12:18 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:53127 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263229AbTECCMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 22:12:18 -0400
Date: Fri, 2 May 2003 22:21:26 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305022224_MC3-1-3729-31F7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   return conf->last_used = new_disk;
>> 
>> (new_disk is a local variable, conf is a function arg.)
>
> Since new_disk is on the stack, is there something about 'conf'
> that guarenetes it is not on the stack too?  F.e. what if
> &conf->last_used were one byte into 'new_disk' or something
> like that.

  It could -- I had thought the -fno-strict-aliasing option
meant exactly the opposite of what it really means.  Since the
compiler has been told to be pessimistic about possibilities
like this maybe that's what it has to do.
------
 Chuck
