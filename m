Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314190AbSDVNcd>; Mon, 22 Apr 2002 09:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314192AbSDVNcd>; Mon, 22 Apr 2002 09:32:33 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:50950 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S314190AbSDVNcc>;
	Mon, 22 Apr 2002 09:32:32 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Mon, 22 Apr 2002 15:31:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [patch] 64bit archs doing incorrect magic for smbfs?
CC: <davem@redhat.com>, <jj@sunsite.ms.mff.cuni.cz>, <davidm@hpl.hp.com>,
        <schwidefsky@de.ibm.com>, <engebret@us.ibm.com>,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <3187FEB377F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Apr 02 at 12:37, Urban Widmark wrote:
> 
> For smbfs the data part is now often sent as a normal ascii string (when
> using samba 2.2.0+) and should then not be modified at all. ncpfs defines
> two different formats (v3 and v4), don't know if both are used.

If you have recent (2.2.0.18/2.2.0.19) ncpfs, format v4 is used (it allows
for 32bit uid/gid). I have no non-ia32 test environment, so if anybody finds 
that ncpfs does not work on any platform, feel free to send patches either 
to me or to arch maintainers...
 
> Untested patch vs 2.4.19-pre7-ac2 below adds version number checks for the
> smbfs case (yes, it handles the ascii format too). Similar changes are
> needed in 2.5.

I plan using ASCII format too, but it is not high enough on my TODO list.
If it will make life for Al or other architectures easier, I'll do it
sooner...
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
