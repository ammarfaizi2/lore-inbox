Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTDVCwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTDVCwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:52:06 -0400
Received: from fmr01.intel.com ([192.55.52.18]:41718 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262885AbTDVCwF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:52:05 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263837@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Tom Zanussi'" <zanussi@us.ibm.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
Date: Mon, 21 Apr 2003 20:04:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Tom Zanussi [mailto:zanussi@us.ibm.com]
> 
> It seems to me that when comparing apples to apples, namely
> considering the complete lifecycle of an event, ... <snip>
> 
> While kue_send_event() in itself is very simple and efficient, it's
> only part of the story, the other parts being the copy_to_user() ...

Agreed - my mistake here in the comparison for leaving out that stuff.

> event.  While kue can avoid this kernel-side copy, it's not possible
> for it to avoid the copy_to_user() since its design precludes mmapping
> the kernel data.  Again, six of one, half dozen of another.  kue looks

Sure - those things, I would say, they compensate one another, 
except for that mmap() detail that pushes the balance towards relayfs
regarding effectiveness when delivering the messages; I think that
at the end the difference should not be too big as the copying of
the data in kue to user space should roughly compensate by the copying
of the data to the relayfs buffer; after all, a copy is a copy.
No data to back this claim though, I am just thinking a mental 
schematic of the lifetime of a bit in both systems out loud.

Or, again, I am missing something ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
