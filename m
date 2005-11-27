Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVK0JQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVK0JQd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 04:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVK0JQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 04:16:33 -0500
Received: from mx02.qsc.de ([213.148.130.14]:53439 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1750940AbVK0JQc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 04:16:32 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCode
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Test patch for ATI/Nvidia timer problems
Date: Sun, 27 Nov 2005 10:14:53 +0100
User-Agent: KMail/1.8.3
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20051126142030.GA26449@wotan.suse.de>
In-Reply-To: <20051126142030.GA26449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511271014.53217.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Saturday 26 November 2005 15:20, Andi Kleen
	wrote: > Everybody who saw timing problems with ATI IXP based boards
	with x86-64 > or some Nvidia NForce4 boards please test this patch.
	Please send > success/failure to me. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 26 November 2005 15:20, Andi Kleen wrote:
> Everybody who saw timing problems with ATI IXP based boards with x86-64
> or some Nvidia NForce4 boards please test this patch. Please send
> success/failure to me.

I try to give your patch a try on the ATI based MSI Megabook S270, today - 
however even with the workaround of "noapic" I had timer drift on resuem from 
ram if the cpu was scaled to a lower frequency when it was suspended.

The k8 cpufreq code failed to assert the current frequency and thus assumed a 
wrong one:

Restarting tasks...<3>powernow-k8: ignoring illegal change in lo freq table-0 
to 0x0
powernow-k8: transition frequency failed
 done

Also my ACPI table only has two frequency entries, 800000 and 1600000 MHz - I 
wonder if one could rework the powernow-k8 driver to interpolate values in 
between to get smoother adaption of the frequency?

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
