Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbTDDRC7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTDDQxf (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 11:53:35 -0500
Received: from siaag1ad.compuserve.com ([149.174.40.6]:6802 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263834AbTDDQwk (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:52:40 -0500
Date: Fri, 4 Apr 2003 12:02:00 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] only use 48-bit lba when necessary
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304041203_MC3-1-3302-C615@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan Quintela wrote:


>Reason is that:
>
>if (expr)
>   var = true;
>else
>   var = false;
>
>is always a bad construct.
>
>var = expr;
>
>is a better construct to express that meaning.


 Yes, but:

   if (expr1 && expr2)
      var = true;
   else
      var = false;

is usually better turned into something that avoids jumps
when it's safe to evaluate both parts unconditionally:

   var = (expr1 != 0) & (expr2 != 0);

or (if you can stand it):

   var = !!expr1 & !!expr2;


--
 Chuck
