Return-Path: <linux-kernel-owner+w=401wt.eu-S932417AbXARPMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbXARPMx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbXARPMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:12:52 -0500
Received: from neopsis.com ([213.239.204.14]:37917 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932417AbXARPMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:12:51 -0500
Message-ID: <45AF92E7.50901@dbservice.com>
Date: Thu, 18 Jan 2007 16:31:51 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Thunderbird 2.0b1 (X11/20061212)
MIME-Version: 1.0
To: Bernhard Walle <bwalle@suse.de>, linux-kernel@vger.kernel.org,
       Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
References: <20070118125849.441998000@strauss.suse.de> <20070118130028.719472000@strauss.suse.de> <20070118141359.GB31418@flint.arm.linux.org.uk>
In-Reply-To: <20070118141359.GB31418@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Neopsis MailScanner using ClamAV and Spaassassin
X-Neopsis-MailScanner: Found to be clean
X-Neopsis-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.374,
	required 5, autolearn=spam, AWL 0.23, BAYES_00 -2.60)
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Jan 18, 2007 at 01:58:52PM +0100, Bernhard Walle wrote: 
>> -static char command_line[COMMAND_LINE_SIZE];
>> +static char __initdata command_line[COMMAND_LINE_SIZE];
> 
> Uninitialised data is placed in the BSS.  Adding __initdata to BSS
> data causes grief.
> 

Static variables are implicitly initialized to zero. Does that also
count as initialization?

tom


