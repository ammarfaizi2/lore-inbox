Return-Path: <linux-kernel-owner+w=401wt.eu-S1751351AbXAPRRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXAPRRO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbXAPRRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:17:14 -0500
Received: from gherkin.frus.com ([192.158.254.49]:2418 "EHLO gherkin.frus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbXAPRRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:17:13 -0500
X-Greylist: delayed 1555 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 12:17:13 EST
Subject: [IPv6] link-local all-nodes ping broken
To: linux-kernel@vger.kernel.org
Date: Tue, 16 Jan 2007 10:51:15 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20070116165116.216DBDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"ping6 -I eth0 ff02::1" worked fine for 2.6.20-rc3, with both Linux
systems on the link responding.  Somewhere in either -rc4 or -rc5 this
quit working.

"tcpdump -i eth0 -l -n ip6" on the remote (same link) Linux system shows
the icmp6 echo request going out on the wire, but no one responds.

One host is running 2.6.20-rc4, the other -rc5.  The results are the
same no matter which direction the test is run.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
