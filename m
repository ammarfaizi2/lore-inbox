Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUDYNDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUDYNDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 09:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDYNDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 09:03:54 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:35214 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262109AbUDYNDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 09:03:53 -0400
Date: Sun, 25 Apr 2004 23:03:38 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc3-mm4 tmpfs, free and free memory reporting
Message-ID: <20040425130338.GB2011@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the OoM killer was being rather brutal to my tasks
even though free was reporting that I had 150meg of ram left. It wasn't
until much later that I realise that I have tmpfs being used as /tmp
and I checked that. Once I cleaned that up a big all was well. The
hassle was, the memory used by tmpfs was being reported as being used
by the cache. That may be so internally but shouldn't it be reported
as actually used ram as it cannot be dumped for processes like a normal
disk cache can and therefore cannot be considered to be 'free' ram.

-- 
    Red herrings strewn hither and yon.
