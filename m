Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290882AbSBLJsT>; Tue, 12 Feb 2002 04:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290881AbSBLJsJ>; Tue, 12 Feb 2002 04:48:09 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:42907 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290878AbSBLJr6>; Tue, 12 Feb 2002 04:47:58 -0500
Message-ID: <3C68E4CB.BE64EBA6@redhat.com>
Date: Tue, 12 Feb 2002 09:47:55 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Internal compiler error in 2.4.5 (hacky workaround)
In-Reply-To: <20020211201505.GA9922@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> This makes gcc survive... adding volatile everywhere ;-).
> 
> int blk_ioctl(volatile kdev_t dev, volatile unsigned int cmd, volatile
> unsigned long arg)
> {
>         volatile request_queue_t *q;
>         volatile struct gendisk *g;
>         volatile u64 ullval = 0;
>         volatile int intval, *iptr;
>         volatile unsigned short usval;

For 2.4 I can see such a workaround being accepted; however for 2.5 I
would say 
to keep the code clean of such things and rather get the compiler fixed
(or the
specific version depricated).
