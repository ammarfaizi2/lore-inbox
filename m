Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTIDGaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTIDGaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:30:23 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:60156 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S264723AbTIDGaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:30:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Date: Thu, 4 Sep 2003 09:30:17 +0300
Message-ID: <2C83850C013A2540861D03054B478C0601CF64F5@hasmsx403.iil.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Thread-Index: AcNwEa03FGABvpAzRpiM4Fh2G8D1tQCm5kNA
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2003 06:30:17.0251 (UTC) FILETIME=[018EAF30:01C372AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You've added a security hole.
> 
> > + 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
> > +		/* if the binary should be opened on behalf of the
> > +		 * interpreter than keep it open and assign it a
> > descriptor */
> > + 		fd = get_unused_fd ();
> > + 		if (fd < 0) {
> 
> At this point your file table might be shared with another thread (see
> binfmt_elf in 2.4 - I dunno if 2.6 has been fixed for this 
> exploit yet).
> You need to unshare the file table before you modify it 
> during the exec.
> 
> Otherwise it looks fairly sane.
> 

Do you know whether the 'unshare_files' patch was already prepared and
sent to the 2.6 maintainer ? If not then I would like to do it.

Thanks,
Yoav.
