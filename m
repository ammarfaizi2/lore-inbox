Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTJKTu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTJKTu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:50:29 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:5393 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263388AbTJKTuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:50:22 -0400
Date: Sat, 11 Oct 2003 12:50:15 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031011195015.GA8724@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <200310100830.03216.kevcorry@us.ibm.com> <20031010182918.GF1084@marowsky-bree.de> <20031011034951.GE4716@pegasys.ws> <20031011132422.GI1084@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011132422.GI1084@marowsky-bree.de>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause sleeplessness, irritability, loss of appetite, anxiety, depression, or other psychological disorders.  Consult your doctor if these symptoms persist.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 03:24:22PM +0200, Lars Marowsky-Bree wrote:
> On 2003-10-10T20:49:51,
>    jw schultz <jw@pegasys.ws> said:
> 
> > I concur with one caviat.  0+1 has the advantage of
> > extendability that doesn't exist with 1+0.
> 
> Right, this annoying complicated approach you describe can be done much
> easier with 1+0. With [EL]VMS?[12] you can simply create a new raid1 set
> and add it as a physical volume to the volume group and then extend the
> LVs accordingly. (I am unsure whether you can add a new disk to a raid0
> set if you don't want to use a volume manager, but if it's not
> currently, it sounds fairly straightforward to add.)
> 
> Your approach with breaking the mirrors etc includes prolonged periods
> of no redundancy and makes me shiver.

I shivered as i wrote it.  I don't consider the periods of
non-redundancy to be prolonged but they are periods of
highest stress on the drives so they are more likely to fail
(even sans Murphy) while doing that than they would
otherwise.  And if you look back at my closing statement
you'll see that i don't recommend it.  I only site it as a
possibility.

Extendibility is i think the only rationalised excuse for
0+1 when 1+0 is available.  I consider it a rationalisation
because by the time you need to extend an array the value of
same-size disks will be questionable.

> [book flogging]
> I am going to recommend reading
> some linux LVM and RAID howtos ;-)
> 
> So, I think, as far as RAID and Volume Management is concerned, Linux
> does pretty well. There's some advanced and fancy stuff missing (>2
> mirrors, online consistency check, etc), but the basics are pretty well
> done.

Absolutely.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
