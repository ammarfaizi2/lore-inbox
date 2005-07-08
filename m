Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVGHFKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVGHFKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVGHFKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:10:54 -0400
Received: from isilmar.linta.de ([213.239.214.66]:5286 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262608AbVGHFKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:10:52 -0400
Date: Fri, 8 Jul 2005 07:10:50 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: st3@riseup.net
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
Subject: Re: speedstep-centrino on dothan
Message-ID: <20050708051050.GA3201@isilmar.linta.de>
Mail-Followup-To: st3@riseup.net, Bill Davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <20050706112202.33d63d4d@horst.morte.male> <42CC37FD.5040708@tmr.com> <20050707235928.71016f61@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707235928.71016f61@horst.morte.male>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:59:28PM +0200, st3@riseup.net wrote:
> read from ACPI tables, while still keeping them available.

You're only keeping some of them available, as you overwrite one such
setting. Alternatively you can increase p.state_count by one early enough.

> index = (((frequency)/100) << 8) | ((voltage - 700) / 16);
> printf ("%u\n", index);
	printf ("0x%x\n", index);
is better

> want 500MHz at 940mV, you could add:
> 
> centrino_model[cpu]->op_points[p.state_count - 2].index = 0x1295;
> centrino_model[cpu]->op_points[p.state_count - 2].index = 500000;
						.frequency
> p.states[p.state_count - 2].core_frequency = 500;


	Dominik
