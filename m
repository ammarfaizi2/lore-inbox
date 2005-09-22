Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbVIVUJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbVIVUJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVIVUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:09:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19648 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030307AbVIVUJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:09:29 -0400
Message-ID: <43330F59.7080503@redhat.com>
Date: Thu, 22 Sep 2005 16:08:57 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Lever, Charles" <Charles.Lever@netapp.com>
CC: Andrew Morton <akpm@osdl.org>, SteveD@redhat.com,
       NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other
 -mm versions)
References: <044B81DE141D7443BCE91E8F44B3C1E288E48E@exsvl02.hq.netapp.com>
In-Reply-To: <044B81DE141D7443BCE91E8F44B3C1E288E48E@exsvl02.hq.netapp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lever, Charles wrote:

>>Actually, Chuck's patch and Steve's aren't quite the same.  
>>Both patches
>>fix the problem that the portmap daemon requires a request to 
>>set something
>>to come from a reserved port.  In addition to this, Steve's 
>>patch reduces
>>the number of reserved ports that the kernel requires.  This 
>>is the problem
>>that resulted in pmap_create() being incorrectly modified in 
>>the first 
>>place.
>>Steve's patch correctly puts the support in rpc_getport() 
>>where it belongs.
>>    
>>
>
>mine does too.  pmap_create() is used for both GET and SET, and i added
>a parm to allow pmap_create()'s caller to request a reserved port when
>needed.
>

Hmmm.  That's not the patch that Andrew Morton included in his email to
linux-kernel then.  That patch just removed the line to set xprt->resvport
to 0.  That one fixed problem but not the other.

    Thanx...

       ps
