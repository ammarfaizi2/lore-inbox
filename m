Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUCFN63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 08:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCFN63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 08:58:29 -0500
Received: from mail.zmailer.org ([62.78.96.67]:13579 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261667AbUCFN62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 08:58:28 -0500
Date: Sat, 6 Mar 2004 15:58:16 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 3Com 3C2000-T support in 2.6?
Message-ID: <20040306135816.GI1653@mea-ext.zmailer.org>
References: <4049AE4F.7080605@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4049AE4F.7080605@clanhk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2004 at 04:56:15AM -0600, J. Ryan Earl wrote:
> I was wondering, has anyone gotten the 3C2000-T gigE card up under 2.6?  
> It apparently comes with driver source for the 2.4 kernel on its CD.  
> Nice specs: 
> http://www.3com.com/products/en_US/detail.jsp?tab=features&sku=3C2000-T&pathtype=support
> 
> Nice sized buffers and IP offload in a cheap package.

   Looks like that driver is related to SysKonnect's  sk98lin  driver.
   It has been branched around december 2002, merging possible missing
   support features to sk98lin baseline would be most usefull. ...

   If anything, present sk98lin  knows _more_ devices, than 3c2000
   driver, including all that 3c2000 knows.  And sk98lin knows about
   IPv4 checksum offloading...


@@ -881,7 +1008,13 @@
 {
 short  i;
 unsigned long Flags;
-char   *DescrString = "sk98lin: Driver for Linux"; /* this is given to PNMI */
+
+/* 2002 12 24 JMA begin
+ * Change to 3Com description. */
+//char  *DescrString = "sk98lin: Driver for Linux"; /* this is given to PNMI */
+char    *DescrString = "3C2000: Driver for Linux"; /* this is given to PNMI */
+/* 2002 12 24 JMA end */
+


> -ryan
