Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271392AbRHTQnd>; Mon, 20 Aug 2001 12:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271393AbRHTQnZ>; Mon, 20 Aug 2001 12:43:25 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:48745 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271392AbRHTQnT>; Mon, 20 Aug 2001 12:43:19 -0400
Message-ID: <3B813E1F.6080204@redhat.com>
Date: Mon, 20 Aug 2001 12:43:11 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Yusuf Goolamabbas <yusufg@outblaze.com>, Cliff Albert <cliff@oisec.net>,
        linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
In-Reply-To: <E15Ymvp-0005rl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>I'm not currently sure what that proves. Is your board intel bios ?
>>>
>>The BIOS is Phoenix (4,0 Release 6.0, BIOS Build 125). Does Intel
>>provide their own branded bios ? Never seen them. The box is an ISP 2150
>>and it is of the Slot 1 variant.
>>
> 
> Ok that sounds unrelated. Intel do provide their own bioses (and one at
> least branded Dell) but Phoenixbios is quite different.

No.  The problem Intel boxes do use Phoenix BIOS.  His box is the exact 
problem model.  It requires the use of IOAPIC support for UP or SMP in 
order to work properly.  If 2.4.8 and 2.4.9 both work correctly now 
*without* the use of UP-IOAPIC and without SMP, then that means in 2.4.8 
there must have been added a DMI scan whitelist entry that makes this 
motherboard do something sane (like never trying to assign interrupts or 
enabling UP-IOAPIC even if it isn't the default).



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

