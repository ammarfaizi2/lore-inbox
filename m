Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTJBOgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTJBOgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:36:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42244 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263359AbTJBOfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:35:12 -0400
Date: Thu, 2 Oct 2003 10:35:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: kartikey bhatt <kartik_me@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO] Testing Module Cleanup.
In-Reply-To: <Law11-F73AHmKqyPmBI00001272@hotmail.com>
Message-ID: <Pine.LNX.4.44.0310021022300.17372-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Oct 2003, kartikey bhatt wrote:

> sending it as an attachment
> 

I'm seeing a failure with the 5th DES ECB test vector:

  testing des ECB encryption
  [...]
  test 5 (64 bit key):
  5630092f0161d576
  fail

Could you also retain the weak key test for DES?  Just add another field
to the test vector struct to indicate that CRYPTO_TFM_REQ_WEAK_KEY needs 
to be set prior to setkey(), then clear it after the test.  (Once you do
this the above test vector should fail anyway, which is probably why it 
is buggy -- it's never been run).

Also, a minor nit: please be careful about this kind of thing:

- * Copyright (c) 2002 Jean-Francois Dive <jef@linuxbe.org>$
+ * Copyright (c) 2002 Jean-Francois Dive <jef@linuxbe.org> ^I$


Otherwise, it looks good.

Thanks,


- James
-- 
James Morris
<jmorris@redhat.com>


