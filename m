Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUL3Kor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUL3Kor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 05:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUL3Kor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 05:44:47 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:62401 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261610AbUL3Kop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 05:44:45 -0500
Message-ID: <41D3DBA1.3020800@tomt.net>
Date: Thu, 30 Dec 2004 11:42:41 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Cc: Bill Davidsen <davidsen@tmr.com>, Diego <foxdemon@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: POSIX ACL's with NFS
References: <d5a95e6d04122712148459507@mail.gmail.com> <41D368F7.8090502@tmr.com> <20041230041013.GB9288@ime.usp.br>
In-Reply-To: <20041230041013.GB9288@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> On Mon, 27 Dec 2004 20:46:38 +0100 (MET), Jan Engelhardt
> <jengelh@linux01.gwdg.de> wrote:
> 
>>config NFS_FS
>>     tristate "NFS file system support"
>>     depends on INET
>>     select LOCKD
>>     select SUNRPC
>>     select NFS_ACL_SUPPORT if NFS_ACL
> 
> 
> Are you using any external patches for getting ACL support in NFS? I'd de
> highly interested in those. I already tried googling but nothing
> enligtening was found apart from the http://acl.bestbits.at/ site. :-/
> 
> 
> Thanks for any pointers, Rogério Brito.
> 

<http://acl.bestbits.at/nfsacl/> contains the most recent available 
patches. I have a few build-fixes pending to submit to Andreas though, 
but those are just gcc-2.95 stuff. And you have to fix up one or two 
patch rejects on anything recent from kernel.org..

It got submitted for inclusion on LKML some time ago, and got a few 
kinks ironed out in that process. Not sure why it hasn't been included yet..

I'm using this set of patches on 2.6.10 and have not noticed any 
problems using it to date. SuSE seems to ship with them too, so it 
probably have had a lot of usage/testing out in the field.
