Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUJAUcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUJAUcC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUJAUbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:31:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:60134 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266308AbUJAUYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:24:42 -0400
Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C985@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230C985@exa-atlanta>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Oct 2004 16:24:27 -0400
Message-Id: <1096662274.1766.94.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 16:08, Bagalkote, Sreenivas wrote:
> The submitted previous version of megaraid (2.20.3.1) had 
> register_ioctl32_conversion & unregister_ioctl32_conversion 
> defined to empty statements if CONFIG_COMPAT was _not_
> defined.


> But I think the preferred way was to have the occurances of 
> (un)register_ioctl32_conversion in the code surrounded by 
> #ifdef CONFIG_COMPAT ... #endif directly. In the kernel source
> only register_ioctl32_conversion has these #ifdef .. #endif. The
> unregister_ioctl32_conversion doesn't.

Actually, because of the way linux/ioctl32 defines these, the #ifdef
CONFIG_COMPAT is unnecessary even around register_ioctl32_...

James


