Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751275AbWFESbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWFESbN (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWFESbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:31:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55454 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751275AbWFESbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:31:12 -0400
Subject: Re: [PATCH 9/9] PCI PM: generic suspend/resume fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149529685.7831.177.camel@localhost.localdomain>
References: <1149497178.7831.163.camel@localhost.localdomain>
	 <1149502891.30554.1.camel@localhost.localdomain>
	 <1149529685.7831.177.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 19:45:58 +0100
Message-Id: <1149533158.30554.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-05 am 13:48 -0400, ysgrifennodd Adam Belay:
> disabled before entering D3 (something that we fail to do before this
> patchset), and the vast majority of devices would end up in this state
> if we were using pci_set_power_state() in this function.

Only if that hardware supports D3 in the first place. That may be the
thing that is critical. 

> With that in mind, any thoughts on giving this a little time in -mm and
> seeing how it fares?  If any problems come up, we could revert to a more
> conservative approach.

It was a question not an objection. If the spec says it is right then it
has to be worth trying

Alan

