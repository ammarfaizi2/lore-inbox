Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWCDXUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWCDXUX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 18:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWCDXUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 18:20:23 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:12204 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751771AbWCDXUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 18:20:23 -0500
Message-ID: <440A2087.4020908@cfl.rr.com>
Date: Sat, 04 Mar 2006 18:19:35 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org, bfennema@falcon.csc.calpoly.edu,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
References: <m3lkwg4f25.fsf@telia.com> <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com> <43F0B8FC.6020605@cfl.rr.com> <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI> <43F1FD39.1040900@cfl.rr.com> <84144f020602142331s756aff15o69d1d67f1b18127e@mai <43F37773.5030203@cfl.rr.com>
In-Reply-To: <43F37773.5030203@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally got around to completing that patch.  Take a look and let me know if it looks good.  I posted it in the thread entitled "[PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget options".  

Phillip Susi wrote:
> Pekka Enberg wrote:
>> Yeah, sounds much better to me. However, I am wondering if we can
>> actually drop the nosave/save cases completely. Wouldn't we get the same
>> semantics by letting uid/gid specify the default id and make the ignore
>> case look like we're always reading -1 from disk, and never writing out
>> any ids? So as a desktop user, you mount with "uid=", "gid=", and
>> "force" passed as mount option and it works as expected.
> 
> True, that would work.  It would require the addition of another mount 
> option though, so I wonder, is that really needed?  What problem with 
> the current patch would this solve?  Is there really a need to save real 
> ids to the disk with the current uid option and no force?  Keep in mind 
> that udf is meant for removable media where the uids aren't going to 
> make any sense in another system.
> 
> 
> Maybe I'm just being lazy though... I'll dig back into it and try to 
> submit a new patch with the force option by this weekend.
> 

