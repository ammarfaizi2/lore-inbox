Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSLBOcN>; Mon, 2 Dec 2002 09:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSLBOcN>; Mon, 2 Dec 2002 09:32:13 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:33787 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264677AbSLBOcM>; Mon, 2 Dec 2002 09:32:12 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021202142048.14630.qmail@web14502.mail.yahoo.com> 
References: <20021202142048.14630.qmail@web14502.mail.yahoo.com> 
To: PK MK <linuxrouter2@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MTD issue 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Dec 2002 14:39:40 +0000
Message-ID: <24561.1038839980@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linuxrouter2@yahoo.com said:
>      Can anybody tell me whether a single MTD partion can span mutiple
> Flash ? This is so that I can have a single JFFS on mutiple flash.
>       Or can I have a single JFFS on Mutiple MTD partitions?

Yes, it can. If the flash chips are identical and arranged consecutively 
with no space between them, the chip drivers will register them all as one 
MTD device anyway. It'll even deal with finding multiple aliases of each 
chip. 

Or if you have different types of flash chip you can use the 'mtdconcat' 
driver to combine them.

This kind of question is more likely to get a useful answer on the MTD 
mailing list (linux-mtd@lists.infradead.org). Certainly not linux-net@vger.

--
dwmw2


