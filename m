Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUHKAZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUHKAZC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267842AbUHKAZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:25:01 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:60317 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267839AbUHKAYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:24:54 -0400
Date: Wed, 11 Aug 2004 02:24:55 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040811002455.GA7537@merlin.emma.line.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de> <200408101228.27455.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408101228.27455.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Gene Heskett wrote:

[burnproof decreases CD quality]
> How so Joerg?  Making a blanket statement such as this requires a good 
> proof example IMO.  You not are giving one.

The switch from read mode to write mode (i. e. find end of data,
increase LASER power to write and pick up writing) takes some time
(order of magnitude: µs) which means some pits/lands aren't right during
that phase. How many pits/lands are broken break depends on hard- and
firmware, write speed and model and for CAV the radial position on the
disc. Fast writers will need to reach a linear velocity around 60 m/s
(216 km/h); one µs time to ramp up LASER power from read to write level
there means up to 60 µm lost.

How far good improvements in the hard- and firmware have allowed to
reduce that gap is beyond my current knowledge. Some figures are posted
at: http://www.digital-sanyo.com/BURN-Proof/tips/No1.html
    http://www.digital-sanyo.com/BURN-Proof/tips/No2.html

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
