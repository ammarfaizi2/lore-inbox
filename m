Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVLNLF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVLNLF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVLNLF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:05:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17092 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932406AbVLNLF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:05:58 -0500
Subject: Re: [PATCH] Add mem_nmi_panic enable system to panic on hard error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <439FDCB0.7030705@jp.fujitsu.com>
References: <439E6C58.6050301@jp.fujitsu.com>
	 <20051213064800.GB7401@redhat.com>
	 <1134476618.11732.7.camel@localhost.localdomain>
	 <439FDCB0.7030705@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 11:05:43 +0000
Message-Id: <1134558344.25663.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I could find your code in the -mm tree. It looks good :-)
> But just one point, isn't it better to use die_nmi() instead of panic()?
> 
>  >>        if (panic_on_unrecovered_nmi)
>  >>                panic("NMI: Not continuing");

At the point we halt for an unrecovered NMI the call trace isnt likely
to be interesting and the message being visible is most important. I'm
not sure if die_nmi would be better therefore - dunno what other folks
think ?

