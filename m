Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUAEGOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 01:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265888AbUAEGOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 01:14:39 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:22328 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S265887AbUAEGOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 01:14:38 -0500
Message-Id: <5.1.0.14.2.20040105171303.04e64ec8@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Jan 2004 17:14:29 +1100
To: Andrew Morton <akpm@osdl.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
Cc: suparna@in.ibm.com, daniel@osdl.org, janetmor@us.ibm.com,
       pbadari@us.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040104212855.0462b75d.akpm@osdl.org>
References: <20040105052846.GA3810@in.ibm.com>
 <20031231025309.6bc8ca20.akpm@osdl.org>
 <20031231025410.699a3317.akpm@osdl.org>
 <20031231031736.0416808f.akpm@osdl.org>
 <1072910061.712.67.camel@ibm-c.pdx.osdl.net>
 <1072910475.712.74.camel@ibm-c.pdx.osdl.net>
 <20031231154648.2af81331.akpm@osdl.org>
 <20040102051422.GB3311@in.ibm.com>
 <20040101234634.53b69a3b.akpm@osdl.org>
 <20040105035518.GA3302@in.ibm.com>
 <20040104210642.2b94038f.akpm@osdl.org>
 <20040105052846.GA3810@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:28 PM 5/01/2004, Andrew Morton wrote:
> >  None. The '>' situation should never occur.
> >
> >  This is just being explicit about covering the "not less than" case
> >  as a whole, and making sure we do not fall through to buffered i/o in
> >  that case, i.e its the same as:
> >  if (!(written < count) && !is_sync_kiocb(iocb))
> >
> >  Is that any less confusing ? Or would you rather just replace the '>=" by
> >  "=='.
>
>Well the original confused the heck out of me!  yes, `if (written == count)'
>should be fine: it says exactly what we want it to say.

perhaps the original was defensive programming against a single-bit-error 
hitting 'written' .... :-)


cheers,

lincoln.
PS. just kidding

