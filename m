Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUJRTbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUJRTbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJRTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:30:00 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:49586 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S267505AbUJRT0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:26:19 -0400
Message-ID: <417418D5.60901@drzeus.cx>
Date: Mon, 18 Oct 2004 21:26:13 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: MMC performance
References: <416A68E5.6080608@drzeus.cx>	 <20041011131919.B19175@flint.arm.linux.org.uk> <1097500722.31259.17.camel@localhost.localdomain> <416AA670.6040109@drzeus.cx> <416ACA91.6040405@drzeus.cx>
In-Reply-To: <416ACA91.6040405@drzeus.cx>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've solved (sort of) the problem with corrupt data when doing multiple 
block writes. It seems the spec I have for the host controller isn't 
quite correct when it comes to clock frequencies.
Copying the value that Windows uses (it doesn't adapt to the card) got 
the card working perfectly. This value is (according to my spec) invalid 
though. I need to hook up an oscilloscope to the device to figure this 
one out.

Russell, the users of my driver have tested the write multiple block 
patch and haven't run into any problems. If you haven't found any issues 
I suggest making it standard.

Rgds
Pierre

