Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263396AbSJFMSr>; Sun, 6 Oct 2002 08:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263398AbSJFMSr>; Sun, 6 Oct 2002 08:18:47 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:40714 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S263396AbSJFMSq>; Sun, 6 Oct 2002 08:18:46 -0400
Date: Sun, 6 Oct 2002 05:24:15 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006122415.GE31878@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no> <20021006021802.GA31878@pegasys.ws> <1033871869.1247.4397.camel@phantasy> <20021006024902.GB31878@pegasys.ws> <20021006105917.GB13046@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021006105917.GB13046@stud.ntnu.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 12:59:17PM +0200, Thomas Langås wrote:
> jw schultz:
> > I stand corrected.  The load average reported will reflect
> > them.  The D-state processes, however, will have nearly zero
> > effect on the system performance, yes?  So in this case the
> > load average reported is simply an infated number.
> 
> They won't have any effect on the system, but the load number is
> insane (we have a 2 CPU intel-boks with a load number of 480)
> and there's like 200-300 (or more) processes hanging in D-state
> with they're FD's and stuff. There _really_ should be a way
> to remove all theese processes, Solaris does this nicely.

That you have that many processes hanging in the D-state is
a concern.  That the load number is inflated is telling you
something is wrong.  If not then the logic feeding the load
number needs changing.

Are all those processes hanging because of NFS?  If so, i'd
start by looking at the mount options as i said before.  I'd
also look into the network and fileserver because something
is wrong.  In my experience Solaris behaved the same way.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
