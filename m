Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288983AbSAITwQ>; Wed, 9 Jan 2002 14:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSAITwD>; Wed, 9 Jan 2002 14:52:03 -0500
Received: from ppp-RAS1-3-100.dialup.eol.ca ([64.56.226.100]:50952 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S288984AbSAITuz>; Wed, 9 Jan 2002 14:50:55 -0500
Date: Wed, 9 Jan 2002 14:50:41 -0500
From: William Park <opengeometry@yahoo.ca>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Message-ID: <20020109145041.A4866@node0.opengeometry.ca>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200201041740.LAA07840@tomcat.admin.navo.hpc.mil> <200201082029.g08KTAA28497@snark.thyrsus.com> <20020108161819.A1878@node0.opengeometry.ca> <200201091843.g09IhnA25130@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201091843.g09IhnA25130@snark.thyrsus.com>; from landley@trommello.org on Wed, Jan 09, 2002 at 05:56:32AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 05:56:32AM -0500, Rob Landley wrote:
> On Tuesday 08 January 2002 04:18 pm, William Park wrote:
> > Hi Rob, how did you manage to get 10TB storage?  It's my understanding
> > that kernel block device still counts 1kB blocks using 32bit (signed)
> > integer.  So, that's 2TB in total.  Are you talking about 5 x 2TB?
> 
> Made a cluster.
> 
> We were extracting stuff out of it via URL, with a database to lookup where 
> each URL lived, so we could have different files live on different servers.  
> (If we'd wanted everything to look like it lived on exactly the same machine, 
> we could have had one machine mount the other machines' space via samba or 
> nfs, but that would have created extra network traffic inside the cluster.)
> 
> The proposed design was to have the whole cluster look like it was at 1 
> public IP address via IP masquerading and port forwarding (port 80 is the 
> apache on node 0, 81 is the apache on node 1, 82 is the apache on node 2...)  
> This was just to save world-routable IPs.  We didn't get that far...
> 
> Bascially, we just wanted lots of storage, cheap and reliable (we were doing 
> RAID 5 across the disks in each cluster), and didn't care what it looked 
> like.  We were also experimenting with DVD jukeboxes to feed data into the 
> cluster (the cluster was cache for larger offline storage, the project was to 
> license syndicated television content (old episodes of mash, battlestar 
> galactica, you name it) and provide video on demand for a flat monthly fee.  
> Each local cable company would have a cluster, which would pull data through 
> the internet from servers in atlanta or california, wherever an ultimate 
> content licensor lived.  It could be shipped around on DVD stacks too...)
> 
> Fun project.  Too bad it didn't work out...

Darn... You could do it nicely now with 10 servers, 1TB in each box.
Since you're only "broadcasting", you can mount the disks read-only,
too. :-)

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>.
8 CPU cluster, NAS, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Tin
