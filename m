Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSHFVCB>; Tue, 6 Aug 2002 17:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSHFVA7>; Tue, 6 Aug 2002 17:00:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60109 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316578AbSHFVAh>; Tue, 6 Aug 2002 17:00:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Luck, Tony" <tony.luck@intel.com>, "Seth, Rohit" <rohit.seth@intel.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Tue, 6 Aug 2002 17:03:24 -0400
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <39B5C4829263D411AA93009027AE9EBB1329958F@fmsmsx35.fm.intel.com>
In-Reply-To: <39B5C4829263D411AA93009027AE9EBB1329958F@fmsmsx35.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061703.24465.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 August 2002 04:38 pm, Luck, Tony wrote:
> > > 4GB TLB entry size ???
> >
> > I assume you mean 4MB TLB entry size or did I fall
> > into a coma for 10 years
>
> That wasn't a typo ... Itanium2 supports page sizes up
> to 4 Gigabytes.  Databases (well, Oracle for sure) want
> to use those huge TLB entries to map their multi-gigabyte
> shared memory areas.
>
> -Tony

Whooooowww...  Power4 I believe opted out at 16MB.
So the story about sleeping beauty is true :-).

Wouldn't want to manage the 8-32 physical pages of memory through the VM.
Paging not an option, file access irrelevant.

In that case I agree that it should be handled by a special purpose
extension like Seth's patch to cover a 4GB page. 

Upto 4MB or so I still believe going the other way is proper.
More later... thanks for the info.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
