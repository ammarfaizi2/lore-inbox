Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266052AbUF2VGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUF2VGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUF2VGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:06:45 -0400
Received: from gherkin.frus.com ([192.158.254.49]:35223 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S266052AbUF2VGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:06:44 -0400
Subject: Doh! kbuild and -msoft-float followup
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Jun 2004 16:06:43 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040629210643.0B5E6DBE8@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved: floating point instructions in Atmelwlandriver pcmcia
modules result from three locations in driver source where division by
"1e6" should be division by "1000000L".  Should have looked over code
again before posting, but lack of sleep and attendant frustration made
me lose patience :-(.  Apologies.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
