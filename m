Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTFLGEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbTFLGEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:04:34 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:27029 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264740AbTFLGEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:04:33 -0400
Date: Thu, 12 Jun 2003 07:18:03 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
Message-ID: <20030612061803.GA21509@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Goerzen <jgoerzen@complete.org>, linux-kernel@vger.kernel.org
References: <87n0go3pcp.fsf@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87n0go3pcp.fsf@complete.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 11:13:26PM -0500, John Goerzen wrote:

 > I am running on a Thinkpad T40p laptop, which has a 1.6GHz Intel
 > Pentium M CPU (this is their "Centrino" CPU; *NOT* the same thing as
 > the Pentium 4 M).

Stay tuned. Jeremy Fitzhardinge wrote a driver for centrino style
speedstep. It's currently getting the kinks worked out on the cpufreq list.
It should turn up in 2.5 sometime real soon, and at some point, maybe
someone will backport it.

 > While we're at it, I'm concerned that Linux is ignoring the sizable
 > cache available on this platform:
 > 
 > $ cat /proc/cpuinfo
 > processor       : 0
 > vendor_id       : GenuineIntel
 > cpu family      : 6
 > model           : 9
 > model name      : Intel(R) Pentium(R) M processor 1600MHz
 > stepping        : 5
 > cpu MHz         : 1598.686
 > cache size      : 0 KB

Looks like missing cache descriptors. Grab x86info[1] and mail me
the output of x86info -c

		Dave

[1] http://www.codemonkey.org.uk/x86info/

