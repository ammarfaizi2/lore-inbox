Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUHWNYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUHWNYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUHWNYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:24:09 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:46285 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S264256AbUHWNYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:24:07 -0400
Message-ID: <4129EFC6.1@ttnet.net.tr>
Date: Mon, 23 Aug 2004 16:23:18 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [2/10]
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > mxser_interrupt() is not inline, why are messing around with it?

it calls mxser_transmit_chars and if it's not moved after it
my gcc failed. (I admit the patches become messy if inlines
are simply not removed but I didn't want to do such changes
where possible).
