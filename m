Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTJVLKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTJVLKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:10:36 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:19469 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id S263546AbTJVLKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:10:34 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB016038FC@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'James Courtier-Dutton'" <James@superbug.demon.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: VIA IDE performance under 2.6.0-test7/8?
Date: Wed, 22 Oct 2003 12:11:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you also send the output from "cat /proc/interrupts".
> It looks like you are not using IO-APIC, but instead using XT-PIC. 
> XT-PIC is a lot slower than IO-APIC.

I am indeed using the XT-PIC, but I was using it under 2.4.21 also, so I
doubt that is the cause of the problems, especially seeing as bartlomiej's
suggestion of increasing the read-ahead caching worked a treat.  

* Does anyone know why the values of the read-ahead caching are so different
between 2.4.x and 2.6.0-test7/8?  It seems to me that there are two
problems;
A) the meaning of the readahead value has changed (almost guaranteed, as in
2.4.21 I can't set anything above 255)
B) the default of 256 is low, as the default in 2.4 of 8 gave me 40Mb/sec
and the default of 256 in 2.6 gives me only 13Mb/s!

I couldn't see any reference to this change of behaviour anywhere on the
kernel mailing list archives.

> Just turn on SMB support in the "make menuconf", and it should enable 
> IO-APIC.

I'll give it a go just in case, however I don't like building kernels with
SMP when I have no need for it.

Cheers

James


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


