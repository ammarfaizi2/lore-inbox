Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWGGDIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWGGDIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWGGDIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:08:52 -0400
Received: from mail.tmr.com ([64.65.253.246]:13741 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751155AbWGGDIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:08:52 -0400
Message-ID: <44ADD223.9010005@tmr.com>
Date: Thu, 06 Jul 2006 23:16:51 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Ric Wheeler <ric@emc.com>, "J. Bruce Fields" <bfields@fieldses.org>,
       Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com>	 <1152189796.5689.17.camel@lade.trondhjem.org> <44ADC3CE.1030302@tmr.com>	 <44ADCA0C.90401@emc.com> <1152240419.6092.16.camel@lade.trondhjem.org>
In-Reply-To: <1152240419.6092.16.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Thu, 2006-07-06 at 22:42 -0400, Ric Wheeler wrote:
>
>  
>
>>The point of using checksums (or digital signatures on files) is to be 
>>able to detect when the on disk file has been corrupted - not to look 
>>for updates.  With normal disks, even writes that are flagged as correct 
>>will occasionally actually end up corrupt on disk.  The rate that you 
>>need to validate the checksums is not at a 4 time a day rate.
>>
>>Buying a nice, high array can make this much less of a concern, but 
>>those of us who get stuck using commodity disks should always have a way 
>>of detecting corruption and a backup (either on tape or on another box).
>>    
>>
>
>I repeat: you do _not_ need high res ctime/mtime updates in order to
>figure out whether or not you need to do a daily backup on your file.
>You do need it in order to figure out if the page you just read in from
>your NFS server 2 microseconds ago is still valid.
>
In most cases you don't care and would be using locking if you did. The 
old value was valid when you read it, the new value is valid, and if 
data is changing in 2us and the change matters, you can't process the 
data before it changes again (or at least may change).

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

