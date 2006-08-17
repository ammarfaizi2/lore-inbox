Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWHQHvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWHQHvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWHQHvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:51:37 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:3017 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S932153AbWHQHvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:51:36 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.5/1.7):. Processed in 1.447431 secs Process 7629)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Relation between free() and remove_vm_struct()
Date: Thu, 17 Aug 2006 13:26:03 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMKEEMDGAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1155797966.4494.29.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

Thnax for your reply.

> second of all, glibc delays freeing of some memory (in the brk() area)
> to optimize for cases of frequent malloc/free operations, so that it
> doesn't have to go to the kernel all the time (and a free would imply a
> cross cpu TLB invalidate which is *expensive*, so batching those up is a
> really good thing for performance)

As per my observation, in two scenarios that I have tried, in one scenario I
am able to see the prints from remove_vm_struct(), but in the other
scenario, I don't see any prints from remove_vm_strcut().

My question is, if there is delayed freeing of virtual address space, it
should be the same in both the scenarios, but its not the case, and this
behavior is consistent for my two scenarios, i.e.. in one I am able to see
the kernel prints and in other I am not, respectively.

Note: I am using glib-2.0-arm.

Regards,
Abu.


