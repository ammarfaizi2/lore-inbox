Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274666AbRJSH53>; Fri, 19 Oct 2001 03:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278335AbRJSH5U>; Fri, 19 Oct 2001 03:57:20 -0400
Received: from tangens.hometree.net ([212.34.181.34]:27317 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S274666AbRJSH5D>; Fri, 19 Oct 2001 03:57:03 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 07:57:35 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9qomdf$obo$1@forge.intermeta.de>
In-Reply-To: <3BCE7568.1DAB9FF0@mandrakesoft.com> <20011018121318.17949@smtp.adsl.oleane.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1003478255 16025 212.34.181.4 (19 Oct 2001 07:57:35 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 19 Oct 2001 07:57:35 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>>> struct device {
>>>         struct list_head        bus_list;
>>>         struct io_bus           *parent;
>>>         struct io_bus           *subordinate;
>>> 
>>>         char                    name[DEVICE_NAME_SIZE];
>>>         char                    bus_id[BUS_ID_SIZE];
>>> 
>>>         struct dentry           *dentry;
>>>         struct list_head        files;
>>> 
>>>         struct  semaphore       lock;
>>> 
>>>         struct device_driver    *driver;
>>>         void                    *driver_data;
>>>         void                    *platform_data;
>>> 
>>>         u32                     current_state;
>>>         unsigned char           *saved_state;
>>> };

>Hi Patrick ! Nice to see this happening ;)

>I would add to the generic structure device, a "uuid" string field.

And a version field! Please add a version field right to the
beginning. This would make supporting legacy drivers in later versions
_much_ easier.

	Ciao
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
