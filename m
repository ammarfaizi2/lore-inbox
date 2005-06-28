Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVF1PlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVF1PlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVF1PlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:41:10 -0400
Received: from styx.suse.cz ([82.119.242.94]:53155 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262085AbVF1Pkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:40:49 -0400
Date: Tue, 28 Jun 2005 17:40:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lenz Grimmer <lenz@grimmer.com>
Cc: linux-thinkpad@linux-thinkpad.org,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Message-ID: <20050628154048.GA11716@ucw.cz>
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz> <20050625150030.GA1636@ucw.cz> <42BD9F1E.5090407@linuxwireless.org> <20050625201442.GB1591@ucw.cz> <42BFF220.2060704@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BFF220.2060704@grimmer.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 02:33:36PM +0200, Lenz Grimmer wrote:

> Hmm, but isn't that exactly the kind of data that is printed by the
> ibm_acpi kernel module in "/proc/acpi/ibm/ecdump" then?
> 
> According to the README "this feature dumps the values of 256 embedded
> controller registers." So shouldn't the reading of the accelerometers
> be included in these values as well?

Not necessarily. The registers are just a way to communicate with the
EC. For example on the amd8111 chipset, the SMBus is accessed through
the EC, and it takes several writes and reads to initiate an SMBus
transaction.

Similarly here, reading the accelerometer may take more than just
reading the register values.

> Or could this mean that the embedded controller might have more than
> these 256 registers that could be read out?

Unlikely, I believe it's byte addressed. But there may be address and
data registers among those, for accessing specific functionality.

> Or does it need to be "told"
> to poll the accelerometer for these values repeatedly?

Quite possibly.

> Many register values in there change automatically (e.g. fan speed), but
> so far we have not seen a pattern of register value changes that look
> like they are related to acceleration of the laptop in any direction.

It really depends on how IBM implemented it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
