Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWELSuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWELSuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWELSuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:50:04 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:62480 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751319AbWELSuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:50:02 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Linux poll() <sigh> again
Date: Fri, 12 May 2006 11:49:35 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMENMLNAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <44649FAB.4080806@huawei.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 12 May 2006 11:45:37 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 12 May 2006 11:45:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This may be a bug somewhere.. however, once again if you don't
> > want read
> > to block under any circumstances, set your sockets to non-blocking!

> But that's another hack. AFAICS why ppl (mostly) use select/poll wud be
> to know if their send/recv/read/write would go thru rather than getting
> blocked!

	It's not another hack. If you don't want to block, you must tell the kernel
that. As for select/poll telling you that a write won't block, it has never
done that. The select/poll functions, just like almost every other system
call, do *not* provide future guarantees.

	DS


