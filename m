Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTICHQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbTICHQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:16:45 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:2280 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S261373AbTICHQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:16:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Date: Wed, 3 Sep 2003 10:16:33 +0300
Message-ID: <2C83850C013A2540861D03054B478C0601CF64EC@hasmsx403.iil.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Thread-Index: AcNx4jDYAzUHY3PlRkS6t2x5yRTy4wAAFoKg
From: "Zach, Yoav" <yoav.zach@intel.com>
To: <torvalds@osdl.org>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Sep 2003 07:16:33.0728 (UTC) FILETIME=[4E0DB400:01C371EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> I don't like the security issues here. Sure, you
> "trust" the interpreter, 
> and clearly only root can set the flag, but to me
> that just makes me 
> wonder why the interpreter itself can't be a simple
> suid wrapper that does 
> the mapping rather than having it done in kernel
> space..
> 

If the binary resides on a NFS drive ( which is a very common practice )
then the suid-wrapper solution will not work because root permissions
are squashed on the remote drive.
