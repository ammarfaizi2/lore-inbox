Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWE3QQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWE3QQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWE3QQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:16:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:59719 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751569AbWE3QQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:16:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O+YBoW2OmujagtlkcxetETbzSpNGkO65aJ09MwCZ+SJ0DfMJ6TGWp4kF9cLPxHT/Zcja249r4Lnmg8NaJK5w1WenMjEEsJUDCzi38xKWikk4KftNe2j4bPQRmCRC44APxEX6hhOuL8YDkvKYPH8ppP5dGVUr3DMILxFqQPA+ODw=
Message-ID: <6bffcb0e0605300916l6e22c814jf9368856f33a9599@mail.gmail.com>
Date: Tue, 30 May 2006 18:16:30 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Ingo Molnar" <mingo@elte.hu>, "Arjan van de Ven" <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
>

Here is small lockdep bug

May 30 18:05:08 ltg01-fedora ainit:
May 30 18:05:09 ltg01-fedora kernel: BUG: warning at
/usr/src/linux-mm/kernel/lockdep.c:1853/trace_hardirqs_on()
May 30 18:05:09 ltg01-fedora kernel:  [<c0103e52>] show_trace_log_lvl+0x4b/0xf4
May 30 18:05:09 ltg01-fedora kernel:  [<c01044b3>] show_trace+0xd/0x10
May 30 18:05:09 ltg01-fedora kernel:  [<c010457b>] dump_stack+0x19/0x1b
May 30 18:05:09 ltg01-fedora kernel:  [<c0139701>] trace_hardirqs_on+0xe7/0x16f
May 30 18:05:09 ltg01-fedora kernel:  [<c02f2b91>] restore_nocheck+0x8/0xb
May 30 18:05:09 ltg01-fedora shutdown[2135]: shutting down for system reboot
May 30 18:05:09 ltg01-fedora init: Switching to runlevel: 6

Here is config
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
