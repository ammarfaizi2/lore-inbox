Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVA0SpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVA0SpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVA0SpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:45:03 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:7823 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262692AbVA0Sol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:44:41 -0500
Message-ID: <41F93690.6070700@us.ibm.com>
Date: Thu, 27 Jan 2005 12:44:32 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <ak@muc.de>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>	 <1105454259.15794.7.camel@localhost.localdomain>	 <20050111173332.GA17077@muc.de>	 <1105626399.4664.7.camel@localhost.localdomain>	 <20050113180347.GB17600@muc.de>	 <1105641991.4664.73.camel@localhost.localdomain>	 <20050113202354.GA67143@muc.de>  <41ED27CD.7010207@us.ibm.com>	 <1106161249.3341.9.camel@localhost.localdomain>	 <41F7C6A1.9070102@us.ibm.com>  <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain>
In-Reply-To: <1106841228.14787.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2005-01-26 at 22:10, Benjamin Herrenschmidt wrote:
> 
>>On Wed, 2005-01-26 at 10:34 -0600, Brian King wrote:
>>Well, I honestly think that this is unnecessary burden. I think that
>>just dropping writes & returning data from the cache on reads is enough,
>>blocking userspace isn't necessary, but then, I may be wrong ;)
> 
> 
> Providing the BARs, cmd register and bridge VGA_EN are cached then I
> think you
> are right.

The first 64 bytes of config space are cached, so this should handle the 
registers you mention above.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
