Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272280AbTHNKqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272287AbTHNKqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:46:04 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:63704 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S272280AbTHNKqB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:46:01 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH]: RO binaries - binfmt_misc, linux-2.6.0-test3
Date: Thu, 14 Aug 2003 13:45:56 +0300
Message-ID: <2C83850C013A2540861D03054B478C0601CF646F@hasmsx403.iil.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: RO binaries - binfmt_misc, linux-2.6.0-test3
Thread-Index: AcNiRhpoSJnNeS13STilKa9dxHGurgACMJOQ
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Muli Ben-Yehuda" <mulix@mulix.org>
Cc: <linux-kernel@vger.kernel.org>, "Sharma, Arun" <arun.sharma@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Goldenberg, Shalom" <shalom.goldenberg@intel.com>,
       "Zemach, Yigal" <yigal.zemach@intel.com>
X-OriginalArrivalTime: 14 Aug 2003 10:45:56.0759 (UTC) FILETIME=[3DF11A70:01C36251]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are running IA-32 binaries on IPF machines using a SW translator.
We have problems with binaries that are non-readable ( it's 
execute-only not read-only. sorry for the misleading subject line )
that reside on an NFS drive. There is no way for the translator
to load these files, even if it had root permissions, because these
permissions are squashed on the remote drive; so giving the translator
setuid/root permissions does not work.

Thanks,
Yoav.

> -----Original Message-----
> From: Muli Ben-Yehuda [mailto:mulix@mulix.org] 
> Sent: Thursday, August 14, 2003 12:26
> To: Zach, Yoav
> Cc: linux-kernel@vger.kernel.org; Sharma, Arun; Mallick, Asit K
> Subject: Re: [PATCH]: RO binaries - binfmt_misc, linux-2.6.0-test3
> 
> 
> On Thu, Aug 14, 2003 at 12:02:44PM +0300, Zach, Yoav wrote:
> > The proposed patch solves a problem for interpreters that need to
> > execute a non-readable file, which cannot be read in 
> userland. To handle
> > such cases the interpreter must have the kernel load the 
> binary on its
> > behalf. 
> 
> In what scenarios does this occur? 
> 
> > The patch is against linux-2.6.0-test3
> 
> Please send patches as inline text, unless they're really big. Thank
> you. 
> -- 
> Muli Ben-Yehuda
> http://www.mulix.org
> 
> 
