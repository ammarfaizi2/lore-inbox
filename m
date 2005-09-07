Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVIGDMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVIGDMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 23:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVIGDMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 23:12:30 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:7835 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750896AbVIGDM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 23:12:29 -0400
Message-ID: <00da01c5b35a$b12b9860$1b00a8c0@cruncher>
Reply-To: "Mike Kirk" <mike.kirk@sympatico.ca>
From: "Mike Kirk" <mike.kirk@sympatico.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Multipath routing changes? "[kernel] Badness in dst_release at include/net/dst.h:154"
Date: Tue, 6 Sep 2005 23:17:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is regarding an external patch to enable routing over multiple network
connections, but I'm wondering if it's revealing another problem:

Up to 2.6.10 and the corresponding patch here:
(http://www.ssi.bg/~ja/#routes-2.6) allowed me to combine cable and DSL
Internet connections. 2.6.11/12/13 (stock kernel from kernel.org + patch
from that URL) all give errors such as (from 2.6.13):

        Sep  6 22:51:08 [kernel] Badness in dst_release at
include/net/dst.h:154
            - Last output repeated 15 times -

...with occasional lines like this:

        Sep  6 22:54:02 [kernel]  [<c03748ac>] __kfree_skb+0xec/0x100

Other than the error messages the system seems to run fine, but it only uses
one of the two Internet connections. Rebooting to 2.6.10 makes the problem
go away and the traffic is balanced over both connections again.

I've emailed the patch maintainer and he mentioned recent kernels have
change multipath routing code and few other people have reported this
problem. I realize since it's an external patch it's not your job to figure
it out, but I thought I'd post my log entries in case I'm seeing a legit
kernel error message.

Regards,

   Mike

