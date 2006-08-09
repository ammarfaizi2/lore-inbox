Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030665AbWHIKYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030665AbWHIKYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030661AbWHIKYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:24:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1452 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030666AbWHIKYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:24:16 -0400
Subject: Re: How to lock current->signal->tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jes Sorensen <jes@sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <yq0u04mtjni.fsf@jaguar.mkp.net>
References: <1155050242.5729.88.camel@localhost.localdomain>
	 <44D8A97B.30607@linux.intel.com>
	 <1155051876.5729.93.camel@localhost.localdomain>
	 <20060808164127.GA11392@intel.com>
	 <1155059405.5729.103.camel@localhost.localdomain>
	 <yq0u04mtjni.fsf@jaguar.mkp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 11:44:10 +0100
Message-Id: <1155120250.5729.146.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 04:09 -0400, ysgrifennodd Jes Sorensen:
> Personally I don't like the current approach. However, I believe the
> philosophy behind it is that users rarely look in dmesg and they
> should be notified (and beaten with a stick) when their badly written
> app spawns unaligned accesses which end up being emulated by the
> kernel.

The users won't seem the anyway, they are hidden behind the GUI.

> These messages are normally caused by userland code, so kprobes
> probably wont do much good :)

Jes, read up on kprobes a little if you think its of no use in these
kind of situations. A systemtap script to count/measure alignment fault
rates and see who is causing the load isn't very hard to write.

Alan

