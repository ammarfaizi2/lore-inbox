Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSHHVr0>; Thu, 8 Aug 2002 17:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSHHVqO>; Thu, 8 Aug 2002 17:46:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12747 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318034AbSHHVqJ>;
	Thu, 8 Aug 2002 17:46:09 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, davej@suse.de, lkml <linux-kernel@vger.kernel.org>,
       Paul Larson <plars@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OF607243C8.ACB54959-ON85256C0F.00771789-85256C0F.0077571A@us.ibm.com>
From: Hubertus Franke <frankeh@us.ibm.com>
Date: Thu, 8 Aug 2002 17:43:30 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Build V60_M14_08012002 Release
 Candidate|August 01, 2002) at 08/08/2002 17:48:41
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


That is true. All was done under the 16-bit assumption
My hunch is that the current algorithm might actually work quite well
for a sparsely populated pid-space (32-bits).
A bitmap-ed based solution is not possible at that point due to space
requirements.

Should be easy to figure out.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003




                                                                                                                                     
                      Rik van Riel                                                                                                   
                      <riel@conectiva.         To:       Hubertus Franke/Watson/IBM@IBMUS                                            
                      com.br>                  cc:       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,         
                                                <andrea@suse.de>, <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>, Paul Larson  
                      08/08/2002 04:15          <plars@austin.ibm.com>, Linus Torvalds <torvalds@transmeta.com>                      
                      PM                       Subject:  Re: [PATCH] Linux-2.5 fix/improve get_pid()                                 
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     



On Thu, 8 Aug 2002, Hubertus Franke wrote:

> Which one sounds like the best one ?
>
> Assuming that for now we have to stick to 16-bit pid_t ....

That assumption is pretty central to the debate.

I don't see the standard get_pid nor the bitmap based
get_pid scale to something larger than a 16-bit pid_t.

If we're not sure yet whether we want to keep pid_t 16
bits it might be worth putting in an algorithm that does
scale to larger numbers, if only so the switch to a larger
pid_t will be more straightforward.

kind regards,

Rik
--
             http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/                    http://distro.conectiva.com/




