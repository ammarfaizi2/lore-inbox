Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTDFV4n (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTDFV4n (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:56:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3551 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263126AbTDFVzn (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:55:43 -0400
Date: Sun, 06 Apr 2003 15:06:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rik van Riel <riel@surriel.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       andrea@suse.de, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Bill Irwin <wli@holomorphy.com>
Subject: Re: subobj-rmap
Message-ID: <2050000.1049666818@[10.10.2.4]>
In-Reply-To: <1600000.1049666582@[10.10.2.4]>
References: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com> <1600000.1049666582@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, lets say we have a file of 1000 pages, or
>> offsets 0 to 999, with the following mappings:
>> 
>> VMA A:   0-999
>> VMA B:   0-200
>> VMA C: 150-400
>> VMA D: 300-500
>> VMA E: 300-500
>> VMA F:   0-999
>> 
>> How would you describe these with independant regions ?
> 
> Good question to illustrate with.
> Extra spacing added just for ease of reading:
> 
> 0-150 -> 150-200 -> 200-300 -> 300-400 -> 400-500 -> 500-999
>  A          A          A          A          A          A
>  B          B
>             C          C          C 
>                                   D          D          
>                                   E          E          
>  F          F          F          F          F          F

Bah, offsets are slightly wrong, but the point is obviously the same

0-150 -> 151-200 -> 201-300 -> 301-400 -> 401-500 -> 501-999
 A          A          A          A          A          A
 B          B
            C          C          C 
                                  D          D          
                                  E          E          
 F          F          F          F          F          F
