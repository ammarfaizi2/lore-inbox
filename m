Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbTDUSbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTDUSbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:31:42 -0400
Received: from fmr02.intel.com ([192.55.52.25]:39158 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261886AbTDUSbj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:31:39 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C2636A5@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'H. Peter Anvin'" <hpa@zytor.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Greg KH'" <greg@kroah.com>, "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
Date: Mon, 21 Apr 2003 11:42:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: H. Peter Anvin [mailto:hpa@zytor.com]
> 
> Perez-Gonzalez, Inaky wrote:
> >
> > Hey! Come on! You don't think I am that lame, do you? Man what
> > a fame I do have!
> >
> > Before the device vaporizes, it recalls the message, so there is
> > no message to read - the same way you take away the sysfs data from
> > the sysfs tree ...
> 
> If you think that will happen with printk(), then, quite frankly, you're
> seriously deluded.

I am kind of deluded, that's for sure. And sore too, but that's another one.

I tend to agree with you; however, it can be done. You would need to adapt
a circular buffer to work with kue. Not a big deal though - just an space 
allocator (that would recall the oldest messages if in need of space) and
the 
'destructor' would just clear the space.

If I get to modify the code to make the destructor thing work (any of these
days), then it will be possible to do it without modifying kue at all.

Now that I think about it, it would work - but I don't think it'd be
really worth it (the per-message overhead would be big for printk,
I'd say). For the record, I really think relayfs could be a better
answer [with the limited reading that so far I had about it].

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
