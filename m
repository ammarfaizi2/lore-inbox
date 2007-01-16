Return-Path: <linux-kernel-owner+w=401wt.eu-S1751756AbXAPWpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXAPWpU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbXAPWpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:45:19 -0500
Received: from gherkin.frus.com ([192.158.254.49]:2479 "EHLO gherkin.frus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748AbXAPWpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:45:18 -0500
Subject: Re: IPv6 router advertisement broken on 2.6.20-rc5
In-Reply-To: <45AD46DD.7050408@aurel32.net> "from Aurelien Jarno at Jan 16, 2007
 10:42:53 pm"
To: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 16 Jan 2007 16:45:17 -0600 (CST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20070116224517.480B4DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jarno wrote:
> I have just tried a 2.6.20-rc5 kernel (I previously used a 2.6.19 one),
> and I have noticed that the IPv6 router advertisement functionality is
> broken. The interface is not attributed an IPv6 address anymore, despite
> /proc/sys/net/ipv6/conf/all/ra_accept being set to 1 (also true for each
> individual interface configuration).
> 
> Using tcpdump, I am seeing the router advertisement messages arriving on
> the interface, but they seems to be ignored.

ACK as far as seeing the same thing.  Another symptom: ping6 to the
link-local all-nodes address (ff02::1) is similarly broken.  tcpdump
shows the packets on the wire, but there's no response.  The most
recent kernel from kernel.org where IPv6 seems to be behaving properly
is 2.6.20-rc3.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
