Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265431AbUFWLYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUFWLYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 07:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUFWLYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 07:24:07 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.140]:57488 "EHLO
	smtpde01.sap-ag.de") by vger.kernel.org with ESMTP id S265431AbUFWLYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 07:24:04 -0400
From: "Christoph Rohland" <cr@sap.com>
To: "'Stas Sergeev'" <stsp@aknet.ru>, "'Hugh Dickins'" <hugh@veritas.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch][rfc] expandable anonymous shared mappings
Date: Wed, 23 Jun 2004 14:23:56 +0300
Message-ID: <054d01c45914$93435d20$1d751e0a@P105541>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <40D55D13.20803@aknet.ru>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stas, Hugh,

> The trick is that I am setting the old_len arg
> of mremap() to 0. This means that the new mapping
> is created while the old one is *not* being
> destroyed. So I get multiple virtual memory
> areas referencing the same shared memory region,
> lets call them "aliases".

I would propose you use the posix shm API for what you want to do and leave
anonymous shared memory as a special case of this like it is...

Keep it simple and stupid!

Just my 2cts
                  Christoph

