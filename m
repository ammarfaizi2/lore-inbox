Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUJAUqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUJAUqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUJAUmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:42:24 -0400
Received: from mail0.lsil.com ([147.145.40.20]:38101 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S266574AbUJAUkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:40:32 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C986@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>
Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
Date: Fri, 1 Oct 2004 16:32:46 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_COMPAT around them, I get "unresolved symbol"
for (un)register_ioctl32_conversion while loading the module.

Thanks,
Sreenivas

>-----Original Message-----
>From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
>Sent: Friday, October 01, 2004 4:24 PM
>To: Bagalkote, Sreenivas
>Cc: Mukker, Atul; 'linux-kernel@vger.kernel.org';
>'linux-scsi@vger.kernel.org'; 'bunk@fs.tum.de'; 'Andrew Morton';
>'Matt_Domsch@dell.com'; Ju, Seokmann
>Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
>
>
>On Fri, 2004-10-01 at 16:08, Bagalkote, Sreenivas wrote:
>> The submitted previous version of megaraid (2.20.3.1) had 
>> register_ioctl32_conversion & unregister_ioctl32_conversion 
>> defined to empty statements if CONFIG_COMPAT was _not_
>> defined.
>
>
>> But I think the preferred way was to have the occurances of 
>> (un)register_ioctl32_conversion in the code surrounded by 
>> #ifdef CONFIG_COMPAT ... #endif directly. In the kernel source
>> only register_ioctl32_conversion has these #ifdef .. #endif. The
>> unregister_ioctl32_conversion doesn't.
>
>Actually, because of the way linux/ioctl32 defines these, the #ifdef
>CONFIG_COMPAT is unnecessary even around register_ioctl32_...
>
>James
>
>
