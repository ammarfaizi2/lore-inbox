Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292320AbSBUK2k>; Thu, 21 Feb 2002 05:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBUK2b>; Thu, 21 Feb 2002 05:28:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:2714 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292323AbSBUK2U>;
	Thu, 21 Feb 2002 05:28:20 -0500
Date: Thu, 21 Feb 2002 11:05:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Allan Sandfeld <linux@sneulv.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Idiot-proof APIC?
In-Reply-To: <E16dc5j-0000CB-00@Princess>
Message-ID: <Pine.GSO.3.96.1020221105543.1033A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Allan Sandfeld wrote:

> I recently had the misfortune to try to put two celerons on an SMP-board. The 
> bios correctly ignored the second cpu, but the linux-kernel(2.4.17). Would 
> boot almost normally then emit two APIC-errors to the console(error 2 and 
> 6?), and shortly after freeze completely. After one of the celerons was 
> removed linux was completely stable. Something inside makes me question 
> whether or not the APIC people have taken idiots into consideration. The 
> kernel should detect two cpu, detect they are not SMP and then operate using 
> just one. Not very importent, but correct behavior.

 Please report a full bootstrap log when started with the "debug" option
if you want anything to be done about it.  Actually it's possible we can
handle such a configuration, but given the BIOS was unable to initialize
the second CPU properly (possibly due to a bug or a misfeature) we may
need to add some sanitizing code.  APIC errors are relatively
insignificant issue here, especially if you only get a few of them --
people report lots of them on systems that should be completely stable (I
have yet to see one myself, but maybe I'm just using weird systems that
completely refuse to generate them... ;-) ). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

