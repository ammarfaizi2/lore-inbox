Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTEEVSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTEEVSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:18:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31188 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261355AbTEEVSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:18:44 -0400
Subject: 32-bit sysinfo on 64-bit platforms
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFB0902053.C3BFF77D-ON86256D1D.00752D8E-86256D1D.007630FA@rchland.ibm.com>
From: "Bryan M Logan" <bryanlog@us.ibm.com>
Date: Mon, 5 May 2003 16:30:56 -0500
X-MIMETrack: Serialize by Router on d27ml101/27/M/IBM(Release 5.0.11  |July 24, 2002) at
 05/05/2003 04:31:07 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this problem in ppc64 and noticed that's it's in the other 64 bit
archs as well.  All except ia64 don't have the totalhigh, freehigh, and
mem_unit fields.  ia64 has the mem_unit field, but will give incorrect info
if totalram is greater than 4GB.  The 2.2 compatibility fix in sys_sysinfo
needs to be undone in these situations.

--
Bryan Logan
IBM eServer Consolidation Development
Dept G9DA - Office: 030-2/E208
Rochester, MN


