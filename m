Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293683AbSCFQ5W>; Wed, 6 Mar 2002 11:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293681AbSCFQ5N>; Wed, 6 Mar 2002 11:57:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23179 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293675AbSCFQ5E>;
	Wed, 6 Mar 2002 11:57:04 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] struct page shrinkage
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF8A6868F1.312B7C40-ON85256B74.005CB22E@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Wed, 6 Mar 2002 11:58:43 -0500
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/06/2002 11:56:45 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Rik van Riel wrote:
>>
>> +               clear_bit(PG_locked, &p->flags);
>
>Please don't do this.  Please use the macros.  If they're not
>there, please create them.
>
>Bypassing the abstractions in this manner confounds people
>who are implementing global locked-page accounting.
>

Andrew,
I have an application which needs to know the total number of locked and
dirtied pages at any given time.  In which application locked-page
accounting is done?   I don't see it in base 2.5.5.   Are there any patches
or such that you can give pointers to?
Bulent


