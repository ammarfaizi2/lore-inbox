Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVAZQ64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVAZQ64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVAZQ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:56:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:48266 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262431AbVAZQzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:55:47 -0500
Date: Wed, 26 Jan 2005 08:52:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <ak@suse.de>,
       albert@users.sourceforge.net, Max Asbock <amax@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, Darren Hart <darren@dvhart.com>,
       David Mosberger <davidm@hpl.hp.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       George Anzinger <george@mvista.com>, Patricia Gaughen <gone@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>, keith maanthey <kmannth@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       lkml <linux-kernel@vger.kernel.org>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Paul Mackerras <paulus@samba.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
In-Reply-To: <OFF640EFCB.17A81893-ON41256F95.0033EA1D-41256F95.00342F11@de.ibm.com>
Message-ID: <Pine.LNX.4.58.0501260851450.1852@schroedinger.engr.sgi.com>
References: <OFF640EFCB.17A81893-ON41256F95.0033EA1D-41256F95.00342F11@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Martin Schwidefsky wrote:

> Why not add an if at the start of gettimeofday to check when the last
> ntp updates has been done and if it has been too long since the last time
> then call ntp_scale ? That way the update isn't done on every call to
> gettimeofday and we don't depend on the regular timer tick.

Because ia64 does not support calling arbitrary C functions in fastcalls.

