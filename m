Return-Path: <linux-kernel-owner+w=401wt.eu-S1161293AbXAHNl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbXAHNl6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbXAHNl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:41:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44095 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161293AbXAHNl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:41:57 -0500
Date: Mon, 8 Jan 2007 13:41:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: akpm@osdl.org, zohar@us.ibm.com, kjhall@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: mprotect abuse in slim
Message-ID: <20070108134152.GA19811@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	zohar@us.ibm.com, kjhall@us.ibm.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, WTF were you smoking when writing the slim code?  Calling mprotect
from random code to rewoke write permissions on process is not okay.  As
is poking into the dile desriptor tables.  As is ding permission checks
based on d_path output.

Andrew, could you please just drop slim?  The code isn't any better than
the last few times they submitted this junk, and it still doesn't serve
any real-life purpose.
