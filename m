Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVCVASv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVCVASv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVCVASI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:18:08 -0500
Received: from pop2.alphalink.com.au ([202.161.124.206]:35673 "EHLO
	pop2.alphalink.com.au") by vger.kernel.org with ESMTP
	id S262163AbVCVAO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:14:26 -0500
From: "Takis Diakoumis" <takisd@alphalink.com.au>
Reply-to: takisd@alphalink.com.au
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 22 Mar 2005 11:14:15 +1100
Subject: Re: 2.6.11 AC patch CD/DVD issues
X-Mailer: DMailWeb Web to Mail Gateway 2.8e, http://netwinsite.com/top_mail.htm
Message-id: <423f6357.2ce4.0@alphalink.com.au>
X-User-Info: 61.29.12.236
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for responding.

>> other ata controllers which then report errors as they can't be unloaded
>> - though i read somewhere on this list that this was by design???).
>
>IDE is designed to be compiled in. There is a lot to do to fix that. -ac
>has hackish unload support in test but the right solution is refcounting
>and driver model based and is in Bartlomiej's dev tree.

should i compile all 'offending' modules into the kernel?

>> all cd ripping/reading tools for audio/multimedia cds report unable to
>> initialize /dev/cdrom (a link to cdrom device).
>
>Are you sure it points to the right device. I've seen similar reports
>where
>/dev/cdrom ended up pointing at the hard disk when the it8212 is added.
>Seems
>some distributions get confused when an IDE controller decides it wants
>to be first.

sorry, i should have been clearer. i am actually changing the link
depending on whether the it8212 controller is enabled in the bios. if
enabled, cdrom is /dev/hdh (dvd is /dev/hdg). if not enabled, cdrom/dvd is
/dev/hdc and hdd. the links are correct, and like i mentioned in the
initial post, i can mount data cds/dvds with no issues whether the
controller is enabled or not. it almost sounds like it thinks the cd and
dvd drives are hard drives and treating them as such. is there perhaps some
additional parameter that should be passed to the kernel on boot, perhaps
with ide-cdrom or similar??

thanks again for responding.
Takis
