Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUHWPeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUHWPeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUHWPbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:31:41 -0400
Received: from imap.gmx.net ([213.165.64.20]:34502 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265098AbUHWP3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:29:20 -0400
Date: Mon, 23 Aug 2004 17:29:19 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: arjanv@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] e1000 - Use vmalloc for data structures not shared
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <15654.1093274959@www31.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you bring an e1000 interface up with a large MTU value (eg 3000 or
9000), we were seeing allocation failures [1].

Perhaps this is relevant here?

--- [1]

http://marc.theaimsgroup.com/?l=linux-kernel&m=109006245518382&w=2

---

On Thu, 2004-07-29 at 18:01, Linux Kernel Mailing List wrote:
> ChangeSet 1.1807.39.3, 2004/07/29 12:01:46-04:00, ganesh.venkatesan@intel
.com
> 
>  [PATCH] e1000 - Use vmalloc for data structures not shared

eh why? You are aware that vmalloc'd datastructures are slower during
use (due to TLB overhead) right ?
These structures also don't look THAT big on first sight....

-- 
Daniel J Blueman

Supergünstige DSL-Tarife + WLAN-Router für 0,- EUR*
Jetzt zu GMX wechseln und sparen http://www.gmx.net/de/go/dsl

