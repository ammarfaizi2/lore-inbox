Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUJNMIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUJNMIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 08:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUJNMIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 08:08:40 -0400
Received: from mx2.magma.ca ([206.191.0.250]:28359 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S261875AbUJNMIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 08:08:38 -0400
Subject: Re: Clock inaccuracy seen on NVIDIA nForce2 systems
From: Jesse Stockall <stockall@magma.ca>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, ACurrid@nvidia.com
In-Reply-To: <20041014012754.25198.qmail@science.horizon.com>
References: <20041014012754.25198.qmail@science.horizon.com>
Content-Type: text/plain
Message-Id: <1097755757.5114.7.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 08:09:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 21:27, linux@horizon.com wrote:
> > The system is running 2.6.9-rc4 and has been up for 2 days. I'm showing
> > an offset of -32 seconds and growing.
> 
> That's -185 ppm (parts per million) error, or -0.0185%.
> 
> Typical cheap quartz crystals are +/- 100 ppm, but there are some cheaper
> than that, and ceramic resonators like
> http://www.ecsxtal.com/cerares.htm
> 
> I know Dave Mills learned from experience that the original +/-100 ppm
> specs in NTP weren't wide enough and he had to change it to cope with
> +/-500 ppm error in some clocks.
> 
> It *could* just be your motherboard's clock source.

possible but....

a) When I boot without 'acpi_skip_timer_override' and I fall back to
using ExtINT for the timer there is no drift.

b) I rebooted and set FSB spread spectrum to 1.0 and let the machine run
over night. In 10 hours of uptime I'm off -45 seconds and growing. This
is -0.125%. So clearly having spread spectrum enabled does affect the
clock.

Thanks

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

