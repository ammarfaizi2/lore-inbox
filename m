Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVFVOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVFVOik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFVOfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:35:06 -0400
Received: from fe-6a.inet.it ([213.92.5.111]:38128 "EHLO fe-6a.inet.it")
	by vger.kernel.org with ESMTP id S261342AbVFVOci convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:32:38 -0400
From: Valerio Vanni <valerio.vanni@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: kernel: __alloc_pages: 0-order allocation failed
Date: Wed, 22 Jun 2005 16:32:32 +0200
Message-ID: <djtib1thpa0pm2oi60e7nci8au2rtkm98m@4ax.com>
X-Mailer: Forte Agent 1.93/32.576 Italiano
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this error on a 2.4.26 kernel:

>Jun 19 23:00:08 server kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>Jun 19 23:00:11 server kernel: __alloc_pages: 2-order allocation failed (gfp=0x1f0/0)
>Jun 19 23:00:11 server kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>Jun 19 23:00:11 server kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
>Jun 19 23:00:12 server kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>Jun 19 23:00:12 server kernel: __alloc_pages: 2-order allocation failed (gfp=0x1f0/0)
>Jun 19 23:00:13 server syslogd: /var/log/messages: Cannot allocate memory
>Jun 19 23:00:13 server kernel: __alloc_pages: 0-order allocation failed  (gfp=0x1f0/0)
>Jun 19 23:00:13 server kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>Jun 19 23:00:13 server kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>Jun 19 23:00:13 server kernel: VM: killing process fetchnews
>Jun 19 23:00:15 server kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)

between these lines there were other saying
>fetchnews[958]: reading XOVER info from /var/spool/news/...

Then I could shut the machine correctly down. No other process than
fetchnews had been killed

Aftere many searches on the net I still don't understand a thing about
this error: how much is it critical?

I mean: is it simply a situation of excessive memory requests that is
fixed by killing one or more processes (and the kernel is still alive
as before) or the kernel is in some way locked up (in particular: is
it necessary/better to reboot? Is there some risk of filesystem
corruption?).

-- 
Ci sono 10 tipi di persone al mondo: quelle che capiscono il sistema binario
e quelle che non lo capiscono.
