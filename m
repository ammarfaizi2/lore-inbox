Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWDBSNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWDBSNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWDBSNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:13:34 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:59055 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750722AbWDBSNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:13:34 -0400
Date: Sun, 2 Apr 2006 20:13:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: IDE CDROM tail read errors
In-Reply-To: <m3hd5ctffo.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.61.0604022011430.12603@yvahk01.tjqt.qr>
References: <m3wtedrrpf.fsf@defiant.localdomain> <Pine.LNX.4.61.0603301016290.30783@yvahk01.tjqt.qr>
 <m3hd5ctffo.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> I have heard from friends that this is due to how readahead works. It 
>> reads beyond the end of the track, and logically, the hardware signals an 
>> error (leading to missing bytes at the end). It is said to be solved using 
>> the -pad option when writing CDs.
>
>You mean the read error and not TOC <> .iso track length differences?

Maps to

  if(toc_len >= iso + pad)
      ok;
  else
      b0rk on last sectors;


