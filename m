Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSHAPED>; Thu, 1 Aug 2002 11:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSHAPED>; Thu, 1 Aug 2002 11:04:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30983 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314885AbSHAPEC>; Thu, 1 Aug 2002 11:04:02 -0400
Message-ID: <3D494D7D.2050506@evision.ag>
Date: Thu, 01 Aug 2002 17:02:21 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <Pine.LNX.4.44.0208011541590.19906-100000@localhost.localdomain> 	<3D493C3B.2060609@evision.ag> <1028218604.15022.59.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Alan Cox napisa³:
> On Thu, 2002-08-01 at 14:48, Marcin Dalecki wrote:
> 
>>And what leads you to the assumption that it is actually the
>>IDE code, which is to be blamed for this?
> 
> 
> Side question Martin - is the IDE flush cache on close stuff in the 2.5
> tree yet. That might be a candidate for this

main.c: printk(KERN_INFO "flushing ATA/ATAPI devices: ");


/*
  * Handle power handling related events ths system informs us about.
  */
static int ata_sys_notify(struct notifier_block *this, unsigned long 
event, void
  *x)
{
         int i;

Yes it is there.

