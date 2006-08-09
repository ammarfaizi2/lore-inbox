Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030638AbWHIKPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbWHIKPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWHIKPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:15:34 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:65251 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1030638AbWHIKP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:15:28 -0400
Message-ID: <44D9A7AE.5060405@namesys.com>
Date: Wed, 09 Aug 2006 03:15:26 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: David Masover <ninja@slaphack.com>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Bernd Schubert <bernd-schubert@gmx.de>, reiserfs-list@namesys.com,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, ipso@snappymail.ca,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <44CF87E6.1050004@slaphack.com> <20060806225912.GC4205@ucw.cz> <44D99ED9.1030003@namesys.com> <20060809094813.GE3308@elf.ucw.cz>
In-Reply-To: <20060809094813.GE3308@elf.ucw.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>On Wed 2006-08-09 02:37:45, Hans Reiser wrote:
>  
>
>>Pavel Machek wrote:
>>
>>    
>>
>>>Yes, I'm afraid redundancy/checksums kill write speed,
>>>
>>>      
>>>
>>they kill write speed to cache, but not to disk....  our compression
>>plugin is faster than the uncompressed plugin.....
>>    
>>
>
>Yes, you can get clever. But your compression plugin also means that
>single bit error means whole block is lost, so there _is_ speed
>vs. stability-against-hw-problems.
>
>But you are right that compression will catch same class of errors
>checksums will, so that it is probably good thing w.r.t. stability.
>
>								Pavel
>  
>
So we need to use ecc not checksums if we want to increase
reliability.   Edward, can you comment in more detail regarding your
views and the performance issues for ecc that you see?
