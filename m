Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTFQWHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTFQWHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:07:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53514 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264952AbTFQWHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:07:25 -0400
Date: Tue, 17 Jun 2003 23:21:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Riley Williams <Riley@Williams.Name>
Cc: davidm@hpl.hp.com, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030617232113.J32632@flint.arm.linux.org.uk>
Mail-Followup-To: Riley Williams <Riley@Williams.Name>, davidm@hpl.hp.com,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>; from Riley@Williams.Name on Tue, Jun 17, 2003 at 11:11:46PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 11:11:46PM +0100, Riley Williams wrote:
> On most architectures, the said timer runs at 1,193,181.818181818 Hz.

Wow.  That's more accurate than a highly expensive Caesium standard.
And there's one inside most architectures?  Wow, we're got a great
deal there, haven't we? 8)

>  > Please do not add CLOCK_TICK_RATE to the ia64 timex.h header file.
> 
> It needs to be declared there. The only question is regarding the
> value it is defined to, and it would have to be somebody with better
> knowledge of the ia64 than me who decides that. All I can do is to
> post a reasonable default until such decision is made.

If this is the case, we have a dilema on ARM.  CLOCK_TICK_RATE has
been, and currently remains (at Georges distaste) a variable on
some platforms.  I shudder to think what this is doing to some of
the maths in Georges new time keeping and timer code.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

