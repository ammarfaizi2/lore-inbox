Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbTDNUu4 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTDNUu4 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:50:56 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:39362 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263735AbTDNUuz (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:50:55 -0400
Date: Mon, 14 Apr 2003 22:02:16 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030414210211.GB7831@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Duncan Sands <baldrick@wanadoo.fr>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304142240.41999.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304142240.41999.baldrick@wanadoo.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 10:40:41PM +0200, Duncan Sands wrote:

 > You would think that the compiler would consider a branch leading to
 > ud2 (i.e. BUG()) to be "unlikely", but it doesn't seem to.  Maybe some
 > improvement can be made there.

BUG_ON is already marked unlikely.
See include/linux/kernel.h

The costs here are doing the actual checks, nothing to do with
the branch prediction.

		Dave

