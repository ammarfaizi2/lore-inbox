Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTEOAjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTEOAjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:39:22 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:60405 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S263277AbTEOAjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:39:20 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Andrew Morton'" <akpm@digeo.com>,
       "'Perez-Gonzalez, Inaky'" <inaky.perez-gonzalez@intel.com>
Cc: <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
Date: Wed, 14 May 2003 17:52:00 -0700
Organization: Murgatroid.Com
Message-ID: <001c01c31a7c$327cc350$175e040f@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030514174158.47c2a3b5.akpm@digeo.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:
> >
> > How does this affect mm_release() in fork.c? there is a 
> call to sys_futex();
> > if you make it conditional, will it break anything in there?
> 
> Via linker magic, mm_release() will simply call 
> sys_ni_syscall() instead.  
> 
> (I ran a futex-free ppc64 kernel.  It worked.)

Yep.  I'm run an ARM kernel as well.  Works fine.

-ch

