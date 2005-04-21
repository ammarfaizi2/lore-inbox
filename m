Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVDULbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVDULbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDULbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:31:36 -0400
Received: from cernmx06.cern.ch ([137.138.166.160]:23501 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S261327AbVDULbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:31:04 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding; 
	b=GvE7w/EkmBDc/uXFpJhXaODkQCCCxRYnzMRwbBDDewEv1GuF4YxxVki3ym0ctKYaGvQMDn9SN29EXk5krKflHJbYgf8baacPZHhic0S6mGsy7rObPNh0smAMLzJYS60z;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX06 CERN MX v2.0 050413.1147 Release
Message-ID: <42678EEA.6070109@cern.ch>
Date: Thu, 21 Apr 2005 13:30:50 +0200
From: Andreas Hirstius <Andreas.Hirstius@cern.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux ia64; en-US; rv:1.7.7) Gecko/20050418
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej ZOLNIERKIEWICZ <Bartlomiej.Zolnierkiewicz@cern.ch>
CC: Gelato technical <gelato-technical@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7
 and later
References: <42669357.9080604@cern.ch> <42668977.5060708@utah-nac.org>	 <42676501.8030805@cern.ch> <58cb370e05042102272ce70f2@mail.gmail.com> <42677587.8030707@cern.ch>
In-Reply-To: <42677587.8030707@cern.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2005 11:30:50.0228 (UTC) FILETIME=[91D5DB40:01C54665]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fls() patch from David solves the problem :-))

Do you have an idea, when it will be in the mainline kernel??

Andreas



Bartlomiej ZOLNIERKIEWICZ wrote:

>
> Hi!
>
>> A small update.
>>
>> Patching mm/filemap.c is not necessary in order to get the improved
>> performance!
>> It's sufficient to remove roundup_pow_of_two from  |get_init_ra_size ...
>>
>> So a simple one-liner changes to picture dramatically.
>> But why ?!?!?
>
>
> roundup_pow_of_two() uses fls() and ia64 has buggy fls() implementation
> [ seems that David fixed it but patch is not in the mainline yet]:
>
> http://www.mail-archive.com/linux-ia64@vger.kernel.org/msg01196.html
>
> That would also explain why you couldn't reproduce the problem on ia32 
> Xeon machines.
>
> Bartlomiej
>
