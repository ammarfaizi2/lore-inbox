Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTDXXRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTDXXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:17:52 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:17886 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S264486AbTDXXRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:17:51 -0400
Date: Thu, 24 Apr 2003 19:25:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304241929_MC3-1-35E8-687C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:


> Two alternatives:
>
> (a)     !!(x & 0x400)
> 
> (b)     (x & 0x400) >> 10



I like either of these:

   #define FOO_BITS 0x400
   #define test_mask(t,m) ( !!((t) & (m)) )
   ...
   return test_mask(x, FOO_BITS);

or

   return (x & FOO_BITS) != 0;

Those double exclamation points should be hidden in macros. :)



------
 Chuck
