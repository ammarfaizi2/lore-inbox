Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTJKDt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 23:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbTJKDt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 23:49:57 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:34064 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263214AbTJKDty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 23:49:54 -0400
Date: Fri, 10 Oct 2003 20:49:51 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031011034951.GE4716@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <200310100830.03216.kevcorry@us.ibm.com> <20031010182918.GF1084@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010182918.GF1084@marowsky-bree.de>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause sleeplessness, irritability, loss of appetite, anxiety, depression, or other psychological disorders.  Consult your doctor if these symptoms persist.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 08:29:18PM +0200, Lars Marowsky-Bree wrote:
> On 2003-10-10T08:30:03,
>    Kevin Corry <kevcorry@us.ibm.com> said:
> 
> > On Friday 10 October 2003 01:19, Stuart Longland wrote:
> > > 	- Software RAID 0+1 perhaps?
> 
> Because RAID 0+1 is a rather bad idea. You want RAID 1+0. Make up the
> fault matrix and simulate what happens if drives fail.
> 
> We can do both though, as Kevin pointed out. So if you want to shot
> yourself in the foot, in the best Unix tradition, we allow you to ;)

I concur with one caviat.  0+1 has the advantage of
extendability that doesn't exist with 1+0.

	1. break mirror downing side A
	2. break stripe A
	3. build new stripe A with added disk(s)
	4. copying stripe B to stripe A
	5. break stripe B
	6. build new stripe B with added disk(s)
	7. build mirror (A->B)

It may even be possible to do this live.  So if gradual
extendability is more important than surviving multiple
failures 0+1 has the advantage.  Normally i prefer the
reliability or to do striping at the logical volume level.


	
	


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
