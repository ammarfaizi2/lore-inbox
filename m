Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTJOND1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTJOND1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:03:27 -0400
Received: from holomorphy.com ([66.224.33.161]:11157 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263068AbTJOND0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:03:26 -0400
Date: Wed, 15 Oct 2003 06:06:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: jbglaw@lug-owl.de
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031015130614.GI765@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, jbglaw@lug-owl.de
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk> <20031015124314.GD20846@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015124314.GD20846@lug-owl.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-14 18:33:49 +0100, John Bradford <john@grabjohn.com>
> wrote in message <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>:
>> No, 2.6 should run on a 4MB 386 with no significant performance
>> penalty against 2.0, in my opinion.

On Wed, Oct 15, 2003 at 02:43:14PM +0200, Jan-Benedict Glaw wrote:
> Achtually, with HZ at around 100 (or oven 70..80), an old i386 or i486
> will *start* just fine, at least at 8MB. However, over some days /
> weeks, the machine gets slower and slower (my testdrive: my 90MHz
> P-Classic with 16MB). Even with that "much" RAM, I get hit by whatever
> slows down the machine. I *think* that it's the MM subsystem, but I'm
> really not skilled enough with it to blame it:)

Well, unless it's an interrupts-safe critical section that's hurting,
you could take profiles, provided you have enough RAM for the profile
buffer (which appears to be large). You could easily do a quick hack
to steal the profile buffer from e820 regions not otherwise used for
RAM (i.e. unused because you did mem=) to handle that for a slow cpu
with more RAM than 8MB.


-- wli
