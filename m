Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbVAFXuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbVAFXuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbVAFXrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:47:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62814
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263101AbVAFXk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:40:58 -0500
Date: Fri, 7 Jan 2005 00:41:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Ems <Richard.Ems@mtg-marinetechnik.de>
Cc: linux-kernel@vger.kernel.org, Hubert Mantel <mantel@suse.de>
Subject: Re: [PROBLEM] Badness in out_of_memory (Plain)
Message-ID: <20050106234104.GX4597@dualathlon.random>
References: <41DD6F67.6070303@mtg-marinetechnik.de> <20050106173052.GW4597@dualathlon.random> <41DD7A96.5060006@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DD7A96.5060006@mtg-marinetechnik.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 06:51:18PM +0100, Richard Ems wrote:
> this! Do you know a memory eater program other than starting lots of 
> mozilla's, OpenOffices's, etc.?

You can run a few of this.

#include <stdio.h>
#include <time.h>

main()
{
	char *p[160];
	int i, j;
	int count;
	for (j=0; j<160; j++)
	{
		p[j] = (char *) malloc(10000000);
	}
	for (count=0;count<2000;count++)
	{
		for (j=0; j<160; j++)
		{
			for (i=0; i<10000000; i+= 4096)
				p[j][i] = 0;
		}
		pause();
	}
}
