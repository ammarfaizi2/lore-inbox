Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWJPMI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWJPMI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWJPMI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:08:56 -0400
Received: from mgw-ext11.nokia.com ([131.228.20.170]:40516 "EHLO
	mgw-ext11.nokia.com") by vger.kernel.org with ESMTP
	id S1422658AbWJPMI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:08:56 -0400
Date: Mon, 16 Oct 2006 15:08:39 +0300
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
To: "philipl@overt.org" <philipl@overt.org>
Cc: Pierre Ossman <drzeus-mmc@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 RFC] mmc: Add support for mmc v4 wide-bus modes
Message-ID: <20061016120839.GA16127@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
References: <21572.67.169.45.37.1160853308.squirrel@overt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21572.67.169.45.37.1160853308.squirrel@overt.org>
X-Operating-System: GNU/Linux angel.research.nokia.com
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 16 Oct 2006 12:08:46.0667 (UTC) FILETIME=[D50121B0:01C6F11B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip and Pierre

On Sat, Oct 14, 2006 at 03:15:08PM -0400, philipl@overt.org wrote:
> I keep getting a data CRC error back - for both the reads and writes.

The spec says these can be ignored, both reads and writes. The
card ignores optional CRC16 when sending data and likewise host
ignores optional CRC when reading back.

Also both the card and the host ignore all but the first two bits of
the test pattern.

> In the command table, it says that it's R1 but the sample code says
NONE.

Both CMD14 and CMD19 have R1 response.

Regards
Jarkko
