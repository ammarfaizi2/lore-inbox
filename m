Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275294AbRJFQmR>; Sat, 6 Oct 2001 12:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275291AbRJFQmH>; Sat, 6 Oct 2001 12:42:07 -0400
Received: from quechua.inka.de ([212.227.14.2]:53617 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S275290AbRJFQlt>;
	Sat, 6 Oct 2001 12:41:49 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <1002357150.3083.20.camel@volk.internalnet>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-pre3-xfs (i686))
Message-Id: <E15puWn-0000RP-00@calista.inka.de>
Date: Sat, 06 Oct 2001 18:42:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1002357150.3083.20.camel@volk.internalnet> you wrote:
>> Well hdparm has a -W option with which you can turn on/off the
>> write cache. If that works (and it appears it does) you should be
>> able to turn write cache off, write *one* block so that the
>> cache gets flushed and turn it back on. I'm not sure how to
>> test this, though.

> Doesn't hdparm -W0f do the work?

We are talking about a write barrier. This means you write all stuff which
can be written unordered (all data) and then you initiate the barrier.. and
if that is finished, you write the commit block. That way you can get
increased write performance and still transaction safe persitence.

Gruss
Bernd
