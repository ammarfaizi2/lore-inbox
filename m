Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268736AbTCCT2g>; Mon, 3 Mar 2003 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268735AbTCCT2g>; Mon, 3 Mar 2003 14:28:36 -0500
Received: from 2etnv5.cm.chello.no ([80.111.51.24]:15746 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268732AbTCCT2O>; Mon, 3 Mar 2003 14:28:14 -0500
Subject: Re: anyone ever done multicast AF_UNIX sockets?
From: Terje Eggestad <terje.eggestad@scali.com>
To: "David S. Miller" <davem@redhat.com>
Cc: cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, linux-net@vger.kernel.org
In-Reply-To: <20030303.105646.02089773.davem@redhat.com>
References: <3E6399F1.10303@nortelnetworks.com>
	<20030303.095641.87696857.davem@redhat.com>
	<3E63A8CB.2090307@nortelnetworks.com> 
	<20030303.105646.02089773.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Mar 2003 20:42:12 +0100
Message-Id: <1046720532.28127.213.camel@eggis1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 19:56, David S. Miller wrote:
       From: Chris Friesen <cfriesen@nortelnetworks.com>
       Date: Mon, 03 Mar 2003 14:11:07 -0500
       
       I haven't done UDP bandwidth testing--I need to check how lmbench
       did it for the unix socket and do the same for UDP.  Local TCP was
       far slower than unix sockets though.
    
    That result is system specific and depends upon how the data and
    datastructures hit the cpu cachelines in the kernel.
    
    TCP bandwidth is slightly faster than AF_UNIX bandwidth on my
    sparc64 boxes for example.

I've seen that their are the same on linux.I tried to to do AF_UNIX
instead of AF_INET internally to boost perf, but to no avail. Makes you
suspect that the loopback device actually create an AF_UNIX connection
under the hood ;-)


-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

