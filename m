Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbUCIVf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbUCIVf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:35:59 -0500
Received: from pop.gmx.net ([213.165.64.20]:7336 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262212AbUCIVf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:35:57 -0500
X-Authenticated: #4512188
Message-ID: <404E38B7.5080008@gmx.de>
Date: Tue, 09 Mar 2004 22:35:51 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, torvalds@osdl.org, len.brown@intel.com
Subject: ACPI PM Timer vs. C1 halt issue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found out what causes higher idle temps when using mm-sources and 
2.6.4-rc vanilla sources: If I use PM Timer as timesource, it seems the 
C1 halt isn't properly called, at least CPU disconnect doesn't seem to 
work, thus leaving my CPU as hot as without disconnect.

using tsc timesource: idle temps of about 45-47°C
using pm timer: 52-53°C idle temps

Is this a bug or a feature?

I have nforce2 hardware. Tell me if you need anything else.

Prakash
