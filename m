Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWELAgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWELAgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWELAgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:36:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:65370 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750756AbWELAgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:36:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=J6bvEYVzcS/eKLV0SsxWlfRL79+Cs/0gtxBZU0lU7/S6rlyCiMa+yTlcDe4xYUzjuGmq9EMZF0niJxnucDhKtbqO3fWFIypjzKkKwHETI9MG2n4MIcFSc21FbpGARO/3KUthhyRLgOLKgK5JtwuMZEjiYUsMqqjARbca5j2dKLU=
From: "Hua Zhong" <hzhong@gmail.com>
To: "=?ISO-8859-1?Q?'Dieter_St=FCken'?=" <stueken@conterra.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: ext3 metadata performace
Date: Thu, 11 May 2006 17:36:41 -0700
Message-ID: <002501c6755c$24306430$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <4463461C.3070201@conterra.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZ1Bw/7aTbnn1UtQem2u1k4sFyRxgAVNkKQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (3ware 9500S), which even has an battery buffered disk cache.
> Thus there is no need for synchronous IO anyway. If I disable 
> the disk cache on my plain SATA disk using ext3, I also get 
> this behavior.

If you mean the disk cache is reliable with the battery, then it should be done by the block layer that a write barrier doesn't
translate into a SYNC (or whatever it is called). Instead, data is considered synced to disk as soon as it hits the cache.

It's really nothing to do with EXT3. It's doing the right thing.

Hua



