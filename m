Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317408AbSFRN6h>; Tue, 18 Jun 2002 09:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317414AbSFRN6h>; Tue, 18 Jun 2002 09:58:37 -0400
Received: from ns.suse.de ([213.95.15.193]:32774 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317408AbSFRN6g>;
	Tue, 18 Jun 2002 09:58:36 -0400
Date: Tue, 18 Jun 2002 15:58:37 +0200
From: Dave Jones <davej@suse.de>
To: Petter <petter@kernelspace.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: small 5575 PCI ATM fix
Message-ID: <20020618155837.S758@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Petter <petter@kernelspace.com>, linux-kernel@vger.kernel.org
References: <20020618133527.GA11756@kernelspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020618133527.GA11756@kernelspace.com>; from petter@kernelspace.com on Tue, Jun 18, 2002 at 03:35:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 03:35:27PM +0200, Petter wrote:
 > 
 > I was grepping through some code, and noticed that the return value
 > of a kmalloc in iphase.c was not checked.
 > A patch was sendt to the author, but this was the reply I got:
 > 
 > "Peter Wang is no longer a member of the Interphase team.  Interphase
 > does support the 5575 PCI ATM adapter with Linux, but for driver enhancements
 > and fixes, we require a current software warranty contract.  If you
 > could send me the serial number and / or the MAC address of your adapter, I
 > can verify your warranty status and have the latest driver sent to you."

rofl. 8-)

 > I do not care about their driver since I do not have an ATM card, but
 > the current driver should anyhow be fixed.

Error handling in that driver seems to be 'creative' at best.
No releasing of already allocated resources, just returning -EAGAIN
everywhere, and no checking for already allocated resources.

Someone with too much time on their hands[1] could probably clean this
up to free allocated resources on failure and return -ENOMEM on
allocation failures.

        Dave

[1] or a 'software warranty contract'.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
