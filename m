Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSL1Qjf>; Sat, 28 Dec 2002 11:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266179AbSL1Qjf>; Sat, 28 Dec 2002 11:39:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13830 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265683AbSL1Qje>; Sat, 28 Dec 2002 11:39:34 -0500
Date: Sat, 28 Dec 2002 16:47:50 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Stephen Satchell <list@fluent2.pyramid.net>, linux-kernel@vger.kernel.org
Subject: Re: Want a random entropy source?
Message-ID: <20021228164750.A5217@flint.arm.linux.org.uk>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Stephen Satchell <list@fluent2.pyramid.net>,
	linux-kernel@vger.kernel.org
References: <5.2.0.9.0.20021228073445.01d386c0@fluent2.pyramid.net> <200212281600.gBSG0P4r001160@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212281600.gBSG0P4r001160@darkstar.example.net>; from john@grabjohn.com on Sat, Dec 28, 2002 at 04:00:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 04:00:25PM +0000, John Bradford wrote:
> I have never understood how a 16-bit DAC or ADC can have noise above
> 96 dB.  Surely _by definition_ a 16-bit DAC or ADC is one that does
> not have noise above that level.

You're assuming that the ADC input is coupled to a noiseless source.
Most ADCs have a chunk of analogue circuitry just before them which
is a nice source of noise.

Not only will noise be picked up via disconnected inputs, but it will
also be picked up via the power supply and ground connections to that
analogue circuit.  How much of that noise gets into the ADC input is
dependent on the quality, design and physical layout of the analogue
circuit.

(As a side note, it's interesting that (what used to be) Crystal
Semiconductor published a large chunk of information on the layout of
boards including the routing of power supplies for combined digital
and analogue circuits (and ADCs fall into that category.))

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

