Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbTAOUKd>; Wed, 15 Jan 2003 15:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTAOUKd>; Wed, 15 Jan 2003 15:10:33 -0500
Received: from adsl-173-18.barak.net.il ([62.90.173.18]:48000 "EHLO
	laptop.slamail.org") by vger.kernel.org with ESMTP
	id <S267021AbTAOUKc>; Wed, 15 Jan 2003 15:10:32 -0500
Message-ID: <3E25C0F3.9000208@slamail.org>
Date: Wed, 15 Jan 2003 22:13:39 +0200
From: Yaacov Akiba Slama <ya@slamail.org>
Reply-To: Yaacov Akiba Slama <ya@slamail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en, fr, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jens Taprogge <taprogge@idg.rwth-aachen.de>
Subject: Re: [PATCH] Re: [BUG] cardbus/hotplugging still broken in 2.5.56
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Taprogge wrote :

>You are not freeing the possibly already allocated resources in case of
>a failure of either pci_assign_resource() or pca_enable_device(). In
>fact you are not even checking if pci_assign_resource() fails. That
>seems wrong to me.

There are two separate issues :
1) Fix the "ressource collisions" problem (and irq not known).
2) Freeing ressources in case of failure of some functions.

My patch solves the first issue only in order to make cardbus with rom work.
The point 2 is a janitor work.

Thanks,
Yaacov Akiba Slama


