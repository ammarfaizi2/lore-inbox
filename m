Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbTFZLlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 07:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbTFZLlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 07:41:14 -0400
Received: from angband.namesys.com ([212.16.7.85]:19913 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265567AbTFZLlN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 07:41:13 -0400
Date: Thu, 26 Jun 2003 15:55:25 +0400
From: Oleg Drokin <green@namesys.com>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: Edward Tandi <ed@efix.biz>, Timothy Miller <miller@techsource.com>,
       reiser@namesys.com, Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466, REISERFS I/O error
Message-ID: <20030626115525.GA13194@namesys.com>
References: <BB1F47F5.17533%kernel@mousebusiness.com> <3EFA2939.2060005@techsource.com> <1056583075.31265.22.camel@wires.home.biz> <200306260825.54076.jbriggs@briggsmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306260825.54076.jbriggs@briggsmedia.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jun 26, 2003 at 08:25:54AM -0400, joe briggs wrote:
> I am working on a Tyan 2466 SMP/Athlon server now and am getting tons of 
> reiserf errors (see attached /var/log/syslog) that claim an i/o error, yet 
> the log does not show any errors from the driver (should it?).  
> Unfortunately, Reiser does not indicate which drive the error is produced 
> from.  My configuration is:
> Tyan 2466 SMP 2 x AMD2400-MP
> 512 MB PC2100 DDR-> not registered!
> Debian woody
> 2.4.21 reiser
> system drive (os, swap) wd800-bb (80 gb ide)
> data drives: 3ware 7200, 2 x wd2000 (200 gb ide) RAID-0

Is not this is one of those heavy-PCI loaded boxes that ocasionally corrupt
data when PCI is overloaded? 
The log you quoted shows that suddenly tree nodes have incorrect content
(and the i/o error is because reiserfs does not know what to do with such nodes).
(and we hope to push the patch that will print device where error have occured
soon).

Bye,
    Oleg
