Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTJ3MEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 07:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJ3MEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 07:04:43 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:58244 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S261696AbTJ3MEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 07:04:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question on SIGFPE
Date: Thu, 30 Oct 2003 17:33:10 +0530
Message-ID: <94F20261551DC141B6B559DC491086727C8C69@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on SIGFPE
Thread-Index: AcOez5nuOw7ywpPYQDC7JtA7iIpKKgADe3gw
From: "Sreeram Kumar Ravinoothala" <sreeram.ravinoothala@wipro.com>
To: "Magnus Naeslund(t)" <mag@fbab.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Oct 2003 12:04:28.0509 (UTC) FILETIME=[F82BD8D0:01C39EDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I tried this. It says that the address is 0. And also I saw that
it doesn't fall into any of the si_codes of SIGFPE.

Regards
Sreeram

---Never doubt that a small group of thoughtful, committed people can
change the world. Indeed, it is the only thing that ever has. -- Copied
from a mail
 

-----Original Message-----
From: Magnus Naeslund(t) [mailto:mag@fbab.net] 
Sent: Thursday, October 30, 2003 3:53 PM
To: Sreeram Kumar Ravinoothala
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on SIGFPE


Sreeram Kumar Ravinoothala wrote:

 > Hi,
 > 	We get this problem when we run it on disk on chip where linux
 > 2.4.5 is used.
 >
 > Thanks and Regards
 > Sreeram

Since I don't know what your app is doing, it's kind of hard to know 
whats causing the problem. I still would guess on a divide by zero, 
maybe because of some timing issue.

Use sigaction(2) to trap the signal, and then look at the 
siginfo_t->si_addr to find out where it happens.

Or better yet, just run the program through gdb, it will catch the
thing...

Magnus

