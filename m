Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263878AbTDNTIO (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTDNTIO (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:08:14 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:39677 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263878AbTDNTIK (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:08:10 -0400
Date: Mon, 14 Apr 2003 13:18:52 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       InterMezzo Development List 
	<intermezzo-devel@lists.sourceforge.net>
Subject: Re: top stack (l)users for 2.5.67
Message-ID: <20030414131852.I26054@schatzie.adilger.int>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	InterMezzo Development List <intermezzo-devel@lists.sourceforge.net>
References: <20030414173047.GJ10347@wohnheim.fh-wedel.de> <1050338275.25353.93.camel@dhcp22.swansea.linux.org.uk> <20030414174645.GK10347@wohnheim.fh-wedel.de> <20030414182544.GA6866@suse.de> <20030414190514.GB12740@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030414190514.GB12740@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Mon, Apr 14, 2003 at 09:05:14PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 14, 2003  21:05 +0200, Jörn Engel wrote:
> On Mon, 14 April 2003 19:25:53 +0100, Dave Jones wrote:
> > On Mon, Apr 14, 2003 at 07:46:45PM +0200, J?rn Engel wrote:
> >  > +/* FIXME: should the below go into some header file? */
> >  > +#define PRESTO_COPY_KML_TAIL_BUFSIZE 4096
> >  >  struct file * presto_copy_kml_tail(struct presto_file_set *fset,
> >  >                                     unsigned long int start)
> >  >  {
> > 
> > so, presto_copy_kml_tail() is only called from
> > presto_finish_kml_truncate(), which doesn't seem to be called
> > from anywhere. What am I missing here? Or can this whole lot
> > just be nuked ?
> 
> No idea. I'm just trying to get the kernel into a state where the
> kernel stack can be reduced to 4k relatively safely.
> As far as intermezzo is concerned, I've never even heard of someone
> using it and care accordingly.
> 
> > If not, this patch introduces a problem.  You're now
> > calling a sleeping function (kmalloc) whilst holding
> > a lock according to the comment above presto_finish_kml_truncate()
> 
> Ack. Would it be ok to malloc with GFP_ATOMIC then, or would you
> propose something different?

I've CC'd the InterMezzo mailing list (which is where the maintainers of
this code live).  Could someone please post a copy of the original patch
to the intermezzo-devel@lists.sourceforge.net mailing list?

Actually, my recollection is that there was previously a patch posted
for fixing this large stack usage the last time this came up.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

