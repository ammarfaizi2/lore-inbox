Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbTC1Xpq>; Fri, 28 Mar 2003 18:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263234AbTC1Xpq>; Fri, 28 Mar 2003 18:45:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:64990 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263216AbTC1Xpl>; Fri, 28 Mar 2003 18:45:41 -0500
Date: Fri, 28 Mar 2003 15:46:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mary Edie Meredith <maryedie@osdl.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [OSDL][BENCHMARK] DBT-2  2.5.65/mjb/osdl comparison data
Message-ID: <60870000.1048895207@flay>
In-Reply-To: <1048889724.2535.329.camel@ibm-e.pdx.osdl.net>
References: <1048889724.2535.329.camel@ibm-e.pdx.osdl.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like you're going to get more bang for the buck for this
benchmark by playing around with some of the IO stuff like readahead
or whatever ...

00000000 total                                    6309908  36.9433
c01089b0 default_idle                             6187707 96682.9219

Not all that much room for improvment with CPU efficiency ;-)

M.

--On Friday, March 28, 2003 14:15:24 -0800 Mary Edie Meredith <maryedie@osdl.org> wrote:

> We have now comparison data for DBT-2 (readprofile included) from
> multiple kernels. To provide a quick comparison for those not
> familiar with DBT-2, we've compared the results, using 2.5.65 stock
> as the baseline (bigger is better).
> 
>                         Score           Score
> Kernel                  Cached          Non-Cached
> 2.5.65 base             100 (baseline)  100
> 2.5.65-mjb2 HZ=100      90.95           99.26
> 2.5.65-mjb2 HZ=1000     102.38          99.92
> 2.5.65-osdl1            101.69          99.89
> 2.5.64-osdl1            104.16          99.67
> 
> HZ is defined as 1000 in the base and osdl1 kernels. mjb2 kernel uses
> Andrew Morton / Dave Hansen patch making HZ a config option of
> 100 Hz or 1000 Hz).  Also we reversed out the 400-shpte patch.
> 
> Link to .config, readprofiles, metric info, raw data:
> 
> http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/8way_2_5_65.html
> 
> 
> Guided tour:
> 
> At the top of the screen, you will see a row that includes the .config
> and the readprofile data for each kernel tested.
> 
> Next is the list of runs of each type, the average metric (Green
> line) bigger numbers are better. The first set of these is the
> cached workload case, second is non-cached.
> 
> Click on "Raw data" for the vmstat, iostat raw info from each run of
> that kernel and workload type.
> 
> 
> Just some things noticed looking at the vmstat plotted data:
> 
> Notible difference in processes waiting for run time, all 2.5.65
> are high relative to 2.5.64(the last frame) for the cached case
> (first row of frames) in these plots:
> http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/r.html
> 
> 
> Of course, interrupts are down for the HZ=100 case (second frame,
> both rows):
> http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/In.html
> 
> Context switches per second slightly down to for HZ=100:
> http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/cs.html
> 
> Moving on to 2.5.66 to escape problems with "sleep".
> 
> Mary Meredith
> Mark Wong
> Cliff White
> 
> Open Source Development Lab
> www.osdl.org
> ~                                             
> -- 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 
> 


