Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTDVFuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 01:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTDVFuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 01:50:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8443 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262941AbTDVFuP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 01:50:15 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16036.55959.965058.999149@lepton.softprops.com>
Date: Tue, 22 Apr 2003 01:00:55 -0500
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Tom Zanussi'" <zanussi@us.ibm.com>,
       "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>
Subject: RE: [patch] printk subsystems
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C263837@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C263837@orsmsx116.jf.intel.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky writes:
 > 
 > > From: Tom Zanussi [mailto:zanussi@us.ibm.com]
 > > 
 > > It seems to me that when comparing apples to apples, namely
 > > considering the complete lifecycle of an event, ... <snip>
 > > 
 > > While kue_send_event() in itself is very simple and efficient, it's
 > > only part of the story, the other parts being the copy_to_user() ...
 > 
 > Agreed - my mistake here in the comparison for leaving out that stuff.
 > 
 > > event.  While kue can avoid this kernel-side copy, it's not possible
 > > for it to avoid the copy_to_user() since its design precludes mmapping
 > > the kernel data.  Again, six of one, half dozen of another.  kue looks
 > 
 > Sure - those things, I would say, they compensate one another, 
 > except for that mmap() detail that pushes the balance towards relayfs
 > regarding effectiveness when delivering the messages; I think that
 > at the end the difference should not be too big as the copying of
 > the data in kue to user space should roughly compensate by the copying
 > of the data to the relayfs buffer; after all, a copy is a copy.
 > No data to back this claim though, I am just thinking a mental 
 > schematic of the lifetime of a bit in both systems out loud.
 > 

Right.  This is what I meant when I said the two were very similar
when considering the lifetime of a single event, ignoring everything
else such as bulk processing via mmap() vs. iterating through a list,
as discussed elsewhere.

 > Or, again, I am missing something ...
 > 
 > Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
 > (and my fault)
 > 

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

