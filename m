Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSE1OBi>; Tue, 28 May 2002 10:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSE1OBh>; Tue, 28 May 2002 10:01:37 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:56584 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S314243AbSE1OBg>; Tue, 28 May 2002 10:01:36 -0400
Date: Tue, 28 May 2002 16:01:35 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 orinoco.c __orinoco_ev_rx question
Message-ID: <20020528160135.D24097@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

after sorting out my sk_buff problem [turned out to be problems with
pcmcia-cs-3.1.33's own include files, which throw away some of the kernel's
config options, thus affecting struct sk_buff declaration] i am now
investigating some things in orinoco.c of 2.4.18, which seems almost
identical to the one from pcmcia-cs

My concern is, if it is really necessary to do the whole rx work in the
interrupt handler, or a bottom half could be used here?
I ask because like this, the interrupt is set for about 800us in a
whole-frame (MTU) receive, which IMHO is not really desirable. I have to
admit i still did not really understand the use of FIDs, so i am not sure,
but couldn't this be taken out of the interrupt handler itself?

(Of course, i can simply implement and try it, but as i am absolutely
not aware about the use of FIDs, i do not want to risk introducing any
nice subtle bugs...)

Regards,
Wolfgang

