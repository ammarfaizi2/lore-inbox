Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXOAI>; Wed, 24 Jan 2001 09:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRAXN76>; Wed, 24 Jan 2001 08:59:58 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:25314 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129401AbRAXN7w>; Wed, 24 Jan 2001 08:59:52 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
cc: Michael McLeod <michaelm@platypus.net>, Nicholas Dronen <ndronen@frii.com>,
        linux-kernel@vger.kernel.org
Message-ID: <802569DE.004CD659.00@d06mta06.portsmouth.uk.ibm.com>
Date: Wed, 24 Jan 2001 13:58:26 +0000
Subject: Re: monitoring I/O
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I can offer the GKHI we put together to make kernel hooks easy to add an
manage. If you know which code paths you need to peek then you can write
you monitor as a kernel mod - user mod pair. The kernel mod will accumulate
the stats, the user mod will extract and report the stats. See the web page
below if you're interested - but note we're very shortly to release a new
version of the GKHI.

Another options is to use dynamic probes - this will require not kernel
modificaitons - again to have to know exactly where you want to place the
probes. Again see the web page below for details.

Richard


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Daniel Kobras <kobras@tat.physik.uni-tuebingen.de> on 24/01/2001 11:57:45

Please respond to Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>

To:   Michael McLeod <michaelm@platypus.net>
cc:   Nicholas Dronen <ndronen@frii.com>, linux-kernel@vger.kernel.org
Subject:  Re: monitoring I/O




On Tue, 23 Jan 2001, Nicholas Dronen wrote:

> Check out the disk_io field in /proc/stat.

Which unfortunately provides only some pieces of information Michael wants
to gather. SCT's sard patches give you much improved statistics that
should basically do what you want. I'm not sure of the current location of
the sard patches but as RedHat puts sard in its kernel, it should be
available somewhere on redhat.com, I suppose. Check out the sysstat
package for userlevel tools. Earlier versions of sard can be found at
ftp.uk.linux.org/pub/linux/sct/fs/profiling/

> On Wed, Jan 24, 2001 at 11:52:36AM +1100, Michael McLeod wrote:
> > I am hoping someone can give me a little information or point me in the
> > right direction.  I would like to write an application that monitors
I/O
> > on a linux machine, but I need some help in determining where to get
the
> > information I'm looking for.  What I would like to do is 'hook' into
the
> > kernel and record information such as volume name, type of request
(read
> > or write), the amount of data being read or written, how long each
> > transaction takes....

Regards,

Daniel.

--
     GNU/Linux Audio Mechanics - http://www.glame.de
              Cutting Edge Office - http://www.c10a02.de
           GPG Key ID 89BF7E2B - http://www.keyserver.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
