Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVLAPRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVLAPRy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVLAPRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:17:54 -0500
Received: from khc.piap.pl ([195.187.100.11]:5124 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932258AbVLAPRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:17:53 -0500
To: Duncan Sands <duncan.sands@free.fr>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: speedtch driver, 2.6.14.2
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
	<200511291214.08104.duncan.sands@free.fr>
	<m3sltf1v0i.fsf@defiant.localdomain>
	<200512010859.19905.duncan.sands@free.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 01 Dec 2005 16:17:51 +0100
In-Reply-To: <200512010859.19905.duncan.sands@free.fr> (Duncan Sands's
 message of "Thu, 1 Dec 2005 08:59:19 +0100")
Message-ID: <m3u0ds7so0.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <duncan.sands@free.fr> writes:

>> ... Since yesterday I have 7 identical MSG D faults and nothing
>> else.
>
> Does increasing the value of CTRL_TIMEOUT help?

I've increased it to 4 seconds, no change. It looks like the response
(or request) is lost somewhere.

The answer is always the same second:

Dec  1 15:20:32 defiant kernel: ATM dev 0: speedtch_check_status entered
Dec  1 15:20:32 defiant kernel: ATM dev 0: speedtch_check_status: line state 20
Dec  1 15:20:37 defiant kernel: ATM dev 0: speedtch_check_status entered
Dec  1 15:20:37 defiant kernel: ATM dev 0: speedtch_check_status: line state 20
Dec  1 15:20:42 defiant kernel: ATM dev 0: speedtch_check_status entered
Dec  1 15:20:42 defiant kernel: ATM dev 0: speedtch_check_status: line state 20

... or it doesn't come at all:

Dec  1 15:20:47 defiant kernel: ATM dev 0: speedtch_check_status entered
Dec  1 15:20:51 defiant kernel: usb 1-1: events/0 timed out on ep0in len=0/4
Dec  1 15:20:51 defiant kernel: ATM dev 0: speedtch_read_status: MSG D failed
Dec  1 15:20:51 defiant kernel: ATM dev 0: error -110 fetching device status

Do the speedtouches have some means (firmware) for debugging or logging?
We would need to see what does the ADSL receive and what does it think
about it.
-- 
Krzysztof Halasa
