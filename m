Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136400AbREDOa6>; Fri, 4 May 2001 10:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136403AbREDOas>; Fri, 4 May 2001 10:30:48 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:34822 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S136401AbREDOal>;
	Fri, 4 May 2001 10:30:41 -0400
Date: Fri, 4 May 2001 16:21:26 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Todd Inglett <tinglett@vnet.ibm.com>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
Message-ID: <20010504162126.A14679@kallisto.sind-doof.de>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Todd Inglett <tinglett@vnet.ibm.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <3AF2A1CC.C22A48E7@vnet.ibm.com> <8541.988980403@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <8541.988980403@ocs3.ocs-net>; from kaos@ocs.com.au on Fri, May 04, 2001 at 10:46:43PM +1000
X-Operating-System: Debian GNU/Linux (Linux 2.4.4-int1-vlan101-nf20010428 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 04, 2001 at 10:46:43PM +1000, Keith Owens wrote:

> For a read only case, the only important
> thing is not to die, one occurrence of bad data is tolerable.

Strong NACK. The pages where the bad data comes from may in some cases
already be reclaimed for other data, probably something security
relevant, which should never ever be given even read access by an
unauthorized user. Even if this event may be a very rare case, one
single occurrence of this is one to much.

Andreas
-- 
>Ich nehm nicht mal Zucker in den den Kaffee.
Dafür nehm ich nichtmal Kaffee.
   (Peter Backof + Bernhard Schultz in detebe)

