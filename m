Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWJXTLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWJXTLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWJXTLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:11:41 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:20626 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161194AbWJXTLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:11:40 -0400
Message-ID: <453E6571.4080504@drzeus.cx>
Date: Tue, 24 Oct 2006 21:11:45 +0200
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
CC: "philipl@overt.org" <philipl@overt.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 RFC] mmc: Add support for mmc v4 wide-bus modes
References: <21572.67.169.45.37.1160853308.squirrel@overt.org> <20061016120839.GA16127@angel.research.nokia.com>
In-Reply-To: <20061016120839.GA16127@angel.research.nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Lavinen wrote:
> Hi Philip and Pierre
> 
> On Sat, Oct 14, 2006 at 03:15:08PM -0400, philipl@overt.org wrote:
>> I keep getting a data CRC error back - for both the reads and writes.
> 
> The spec says these can be ignored, both reads and writes. The
> card ignores optional CRC16 when sending data and likewise host
> ignores optional CRC when reading back.

If this is the case, then we cannot support it the way the MMC layer is
built right now. A CRC error means the data is bad and might not even be
in the buffer.

To be honest, many controllers will probably not even transfer the data
to the CPU, so we can't just ignore the CRC error. So for now, I guess
this will have to be an unsupported feature.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
