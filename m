Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbULIP5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbULIP5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbULIP5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:57:09 -0500
Received: from main.gmane.org ([80.91.229.2]:63923 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261535AbULIP5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:57:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Date: Thu, 09 Dec 2004 10:57:05 -0500
Message-ID: <87k6rr5usu.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com> <20041206215456.GB10499@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:tyu4WD1qDhsG++7XSJfZg9fHZ98=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

...
>> +typedef struct Bufq Bufq;
>> +struct Bufq {
>> +	Buf *head, *tail;
>> +};
>
> What's wrong with the in-kernel list structures that you need to create
> your own?

The Buf structures are singly linked (one next pointer).  We could
convert it to use list.h, but that would mean having another pointer
per list element.

-- 
  Ed L Cashin <ecashin@coraid.com>

