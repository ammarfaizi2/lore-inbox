Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRKFNzy>; Tue, 6 Nov 2001 08:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279321AbRKFNzp>; Tue, 6 Nov 2001 08:55:45 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:5034 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S279313AbRKFNzc>; Tue, 6 Nov 2001 08:55:32 -0500
Subject: Re: How can I know the number of current users in the system?
From: Terje Eggestad <terje.eggestad@scali.no>
To: Nicholas Berry <nikberry@med.umich.edu>
Cc: amon@vnl.com, weixl@caltech.edu,
        mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <sbe793a0.090@mail-01.med.umich.edu>
In-Reply-To: <sbe793a0.090@mail-01.med.umich.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 06 Nov 2001 14:44:14 +0100
Message-Id: <1005054258.1221.122.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Absolutly true. 

You can get a 90% solution by testing for tty and for proces that has a
connection to a tcp port between 6000 and 6100 somewhere or has a unix
socket to /tmp/.X11-unix/X0 (or whereever X chooses to place the unix
socket). 

But thats definitly not good enough to base your scheduling on.

TJ

tir, 2001-11-06 kl. 13:38 skrev Nicholas Berry:
    It depends whether you're looking for an idea of who's on, or you want a definitive count. The lattter is basically almost impossible. What if a logged-in user nohups two xterms to different X-servers, then logs out - how many people are logged in? I've spent a hell of a long time working on this on AIX for a certain German bank, and the bottom line is that it can't be done. What is 'logged on' anyway? Someone running bash or ksh, that's cool, but what about someone running /home/fred/myprog? Is it a shell?
    
    Basically once Unix went beyond serial terminals connected to dumb serial ports, we lost the ability to track users.
    
    Nik
    
    
    > Hmmm, you should be able to count the number of pty's and tty's.
    > Every logged in user is attached to some sort of getty
    > whose parent is the init task (1). That might be a basis for
    > a count.
    
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

