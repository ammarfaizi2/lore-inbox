Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTDNUsz (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTDNUsz (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:48:55 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:30402 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263698AbTDNUsy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:48:54 -0400
Date: Mon, 14 Apr 2003 22:00:14 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030414210006.GA7831@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80690000.1050351598@flay>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 01:19:58PM -0700, Martin J. Bligh wrote:
 > Seems all these bug checks are fairly expensive. I can get 1%
 > back on system time for kernel compiles by changing BUG to 
 > "do {} while (0)" to make them all compile away. Profiles aren't
 > very revealing though ... seems to be within experimental error ;-(
 > 
 > I was pondering CONFIG_RUN_WILD_NAKED_AND_FREE

The sort of folks who would worry about that very last 1% are the
sort of people that would more than likely hit these BUGs as they're
really stressing things.

Losing a bunch of potential reports (and possibly doing bad things),
in the name of a 1% performance boost doesn't sound too productive to me.

		Dave

