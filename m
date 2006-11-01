Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752365AbWKAVDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbWKAVDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbWKAVDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:03:51 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:54289 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1752365AbWKAVDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:03:50 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: How does the kernel interrupt a user process with code while (1) {}?
Date: Wed, 1 Nov 2006 13:03:32 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEHEPHAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3dd9a95e0611010712j9f4c021m1673eeda6af30c49@mail.gmail.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 01 Nov 2006 14:06:43 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 01 Nov 2006 14:06:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks.
>
> On 11/1/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > >
> > > As title, thanks ;-)
> >
> > Timer interrupt.

Other interrupts too. For example, if a disk I/O operation completes (or a
network packet is received) and generates an interrupt, the kernel could use
that interrupt to switch to another process made ready-to-run by the disk
operation or data received over the network.

Any interrupt can interrupt a user process.

DS


