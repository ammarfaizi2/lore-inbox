Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130605AbRAXC1n>; Tue, 23 Jan 2001 21:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130767AbRAXC1e>; Tue, 23 Jan 2001 21:27:34 -0500
Received: from 216-175-174-69.client.dsl.net ([216.175.174.69]:53002 "HELO
	frank.eargle.com") by vger.kernel.org with SMTP id <S130605AbRAXC1U>;
	Tue, 23 Jan 2001 21:27:20 -0500
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: No SCSI Ultra 160 with Adaptec Controller
Message-ID: <980303238.3a6e3d866d603@eargle.com>
Date: Tue, 23 Jan 2001 21:27:18 -0500 (EST)
From: Tom Sightler <ttsig@tuxyturvy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

While trying to determine why my SCSI Ultra 160 drives don't work on my Dell 
PowerApp.Web 100 I noticed this section of code:

      /*
       * This is needed to work around a sequencer bug for now.  Regardless
       * of the controller in use, if we have a Quantum drive, we need to
       * limit the speed to 80MByte/sec.  As soon as I get a fixed version
       * of the sequencer, this code will get yanked.
       */
      if(!strncmp(buffer + 8, "QUANTUM", 7) &&
         p->transinfo[tindex].goal_options )

Since this machine has Quantum drives I guess this is my problem.  Does anyone 
know if this code is still actually neccessary?  It seems it's been there a 
while.  It's dissapointing to not get full performance out of the hardware you 
have.

Thanks,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
