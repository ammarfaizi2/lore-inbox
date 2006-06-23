Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWFWOgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWFWOgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFWOgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:36:54 -0400
Received: from [81.2.110.250] ([81.2.110.250]:12229 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750793AbWFWOgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:36:53 -0400
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal
	handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <w@1wt.eu>
Cc: pageexec@freemail.hu, Andi Kleen <ak@suse.de>, marcelo@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060623133217.GA24737@1wt.eu>
References: <449BC808.4174.277D15CF@pageexec.freemail.hu>
	 <449C0616.4382.286F7C8C@pageexec.freemail.hu>
	 <20060623133217.GA24737@1wt.eu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 15:51:50 +0100
Message-Id: <1151074310.4549.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 15:32 +0200, ysgrifennodd Willy Tarreau:
> If I understand it well, an application which maps address 0 has no way to
> be notified that the kernel detected a corrupted stack pointer. 

A debugger can deal with this corner case if it ever needs to be careful
mapping and remapping of the page. Very few apps map data at the zero
page and those that do usually map a single zero page which probably
isn't PROT_EXEC anyway.

(The usual case is to speed up pointer chain walking by knowing that
NULL->NULL->... is always NULL)

Alan

