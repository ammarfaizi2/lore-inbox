Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135413AbRD3QbI>; Mon, 30 Apr 2001 12:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135509AbRD3Qa7>; Mon, 30 Apr 2001 12:30:59 -0400
Received: from alpo.casc.com ([152.148.10.6]:30628 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S135413AbRD3Qaw>;
	Mon, 30 Apr 2001 12:30:52 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.37569.205459.898540@gargle.gargle.HOWL>
Date: Mon, 30 Apr 2001 12:28:49 -0400
To: esr@thyrsus.com
Cc: John Stoffel <stoffel@casc.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
In-Reply-To: <20010429183526.B32748@thyrsus.com>
In-Reply-To: <20010427193501.A9805@thyrsus.com>
	<15084.12152.956561.490805@gargle.gargle.HOWL>
	<20010429183526.B32748@thyrsus.com>
X-Mailer: VM 6.90 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric> John Stoffel <stoffel@casc.com>:
>> Which is a real PITA because now I have to edit my .config file to
>> have:
>> 
>> CONFIG_RTC=y

Eric> The correct fix for this PITA is for Linus not to ship a broken
Eric> defconfig.

While I can sympathize with this comment, I still feel that CML2 needs
to be more robust and handle corner cases like this more gracefully.  

Eric> I hear you.  The problem is that "what's wrong" is not as
Eric> well-defined as one might like.  In this case the error could be
Eric> in the setting of X86, SMP, or RTC.  CML2 has no way to know
Eric> which of these is mis-set, so it can't know which one to pop
Eric> up..

It should then highlight *all* of the potential problem config
setting(s) and let the user deal.  But they should never be forced to
hand edit their config file because a dependency is broken somewhere.
CML2 should enforce the *writing* of compliant files, but should deal
gracefully with non-compliant ones.  Within reason of course.  
 
Eric> USB and SCSI are both enabled/disabled in the system buses menu.
Eric> The apparent confusion

Then they should be pushed down a level to be under those buses.  They
don't belong on the top level.

More correctly, *any* configuration setting on an upper level should
not depend on a lower level setting.  I know, this is probably not
possible for a variety of reasons, but I feel pretty strongly that we
should try to keep common options near/next to each other.

I can see where this would be a problem, using just SCSI as an
example, since you could have ISA, PCI or some other system bus SCSI
controller(s) on the system.  So where do you allow users to choose
whether to enable SCSI or not?  At the top level?  Only under the
"System Busses" menu item?

On the other hand, I really do like the search feature for config
stuff, it seems pretty powerful.

Thanks,
John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
