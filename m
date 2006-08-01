Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWHAIPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWHAIPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWHAIPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:15:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49149 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422771AbWHAIPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:15:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "G SR" <gsr.lkml@gmail.com>
Subject: Re: [help] Bottom half scheduling
Date: Tue, 1 Aug 2006 10:15:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <b60ce1b70607310536y17e29fbcp8b827a17eaf98511@mail.gmail.com>
In-Reply-To: <b60ce1b70607310536y17e29fbcp8b827a17eaf98511@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011015.40098.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Monday 31 July 2006 14:36 schrieb G SR:
> The question is: Which tasklet will come into execution when the
> interrupt task completes?. In other words whether the pre-empted
> tasklet will resume its exec-
> ution or the newly scheduled tasklet will execute?

The one that was interrupted will complete first, then the other
one executes. Note that softirqs that are scheduled from other
softirqs may get deferred to execute from ksoftirqd, at a later
point in time.

	Arnd <><
