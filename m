Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTFDOmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTFDOmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:42:36 -0400
Received: from unthought.net ([212.97.129.24]:6621 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263338AbTFDOmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:42:35 -0400
Date: Wed, 4 Jun 2003 16:56:03 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030604145603.GJ14947@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Michael Frank <mflt1@micrologica.com.hk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Marc Wilson <msw@cox.net>, lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <20030529055735.GB1566@moonkingdom.net> <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva> <200306040030.27640.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306040030.27640.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:30:27AM +0800, Michael Frank wrote:
...
> >
> > Ok, so you can reproduce the hangs reliably EVEN with -rc6, Marc?
> 
> -rc6 is better - comparable to 2.4.18 in what I have seen with my script.  

I've run 2.4.20 for a long time, and have been seriously plagued with
the I/O stalls.

On a file server (details below) here I upgraded to 2.4.21-rc6
yesterday.

The I/O stalls have *almost* gone away.

Best of all, we still have our data intact  ;)

Server data:
  ~130 GB data on a ~150 GB ext3fs with >1 million files
  Software RAID-0+1 on four IDE disks
  Two promise controllers 1x20262 1x20269
  1x Intel eepro100, 1x Intel e1000
  dual PIII, half a gig of memory
  NFS server (mainly v3, many different clients)

> 
> After the long obscure problems since 2.4.19x, -rc6 could use serious 
> stress-testing. 

This server rarely has load below 1, but frequently above 15.  It may
run some compilers and linkers locally, but most of the load comes from
NFS serving.

So far it's been running for 28 hours with that kind of load.  Nothing
suspicious in the dmesg yet.

I will of course let you all know if it falls on it's knees.


So far it's all thumbs-up from me!   There may still be an occational
stall here and there, but compared to 2.4.20 this is heaven (it really
was unbelievably annoying having your emacs stall for 10 seconds every
30 seonds when someone was linking on the cluster)  :)

A big *thank*you* to Marcelo for deciding to include a fix for the I/O
stalls!

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
