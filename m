Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319577AbSH3Oux>; Fri, 30 Aug 2002 10:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319578AbSH3Ouu>; Fri, 30 Aug 2002 10:50:50 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:52118 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S319577AbSH3OuO>; Fri, 30 Aug 2002 10:50:14 -0400
Date: Fri, 30 Aug 2002 07:54:03 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: AMD 768 USB Controller
To: aby_sinha@yahoo.com
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <3D6F870B.2050407@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <E17kiqo-00058S-00@usw-sf-list2.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wouldn't necessarily expect problems with an AMD 768
but this oops message looks a bit familiar:

> lh35s: EIP is at dl_done_list [usb-ohci] 0X76
> (2.4.18-3SMP)

Try the 2.4.20-pre5 kernel code, which includes a
patch to usb-ohci.c (changeset 1.587.1.11) that may
help ... specifically the five lines making an ED
be ED_NEW, when the controller hadn't yet stopped
using that data, could later oops dl_done_list().

- Dave



