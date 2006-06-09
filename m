Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWFINKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWFINKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbWFINKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:10:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965251AbWFINK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:10:29 -0400
Message-ID: <44897337.1090309@redhat.com>
Date: Fri, 09 Jun 2006 09:10:15 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on setattr	request
References: <4485C3FE.5070504@redhat.com>	<1149658707.27298.10.camel@localhost>	<4486E662.5080900@redhat.com> <17544.50037.863862.736802@cse.unsw.edu.au>
In-Reply-To: <17544.50037.863862.736802@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Wednesday June 7, staubach@redhat.com wrote:
>  
>
>>Neil, can we get these changes integrated, please?
>>    
>>
>
>Nope.
>The discussion has already gone on from here, so I might be covering
>old ground, but there seem to be further mentions of still needing the
>server patch, so just to be sure it is covered....
>
>My reading of SUS says that 
>  open(O_TRUNC) of an empty file does not update the modify time
>  truncate() of an empty file does update the modify time
>
>  
>

These seem backwards.

>So the server has to be able to support this distinction without being
>able to directly know what API call was made on the client.
>The patch you suggest makes it impossible to support that distinction.
>
>Possibly the server could make a distinction between when nfsd_setattr
>is called directly, and when it is called via nfsd_create{,_v3}.  I
>would be more open to a patch that makes a distinction there.  However
>I think that it would be best for the client to be explicit about what
>it is doing by setting the right attr flags.
>

Yup, agreed.  I do think that we are going to have some interoperability
problems with some existing clients in the marketplace though.  Perhaps
we can get some of those folks to look at their clients and make them a
little more explicit about what bits needs to be changed, as opposed to
assuming that the server would just do what the client expected.

    Thanx...

       ps
