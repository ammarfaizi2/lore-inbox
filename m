Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWIOWYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWIOWYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWIOWYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:24:25 -0400
Received: from mail1.webmaster.com ([216.152.64.169]:10503 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932307AbWIOWYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:24:25 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP question.
Date: Fri, 15 Sep 2006 15:23:34 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGECFOHAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <a885b78b0609150007u239cf363l40dd122165f7b516@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 15 Sep 2006 15:26:37 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 15 Sep 2006 15:26:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My two adapters has two different IP address, and I bind one IP
> on one socket,
> do you mean that I alloc two socket and bind different IP is not
> helpful?

	Correct. You are still sending all the packets *to* the same place.

> In fact, all the packet sent from two socket is go out by one
> network adapter?

	Yes, of course. Why would the kernel send traffic to a destination out an
interface that doesn't go to that destination?

	Suppose you have two interfaces, 1.2.3.4/8 and 10.2.3.4/8, if you are
sending a packet *to* 1.2.4.5, it will go out the first interface. This
applies whether the source address is 1.2.3.4 or 10.2.3.4.

	By default, the kernel routes traffic based on where it is going, not which
interface address it came from.

	DS


