Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbSKSSZ3>; Tue, 19 Nov 2002 13:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267076AbSKSSZ3>; Tue, 19 Nov 2002 13:25:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52457 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267072AbSKSSZ1>;
	Tue, 19 Nov 2002 13:25:27 -0500
Date: Tue, 19 Nov 2002 18:30:54 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ducrot Bruno <poup@poupinou.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021119183054.GA6771@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ducrot Bruno <poup@poupinou.org>, linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119142731.GF27595@poup.poupinou.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:27:31PM +0100, Ducrot Bruno wrote:
 > > The newer ACPI code also introduces problems that aren't
 > > present with the current 2.4.20rc code.

Got it. This actually isn't a problem with new ACPI code, but
the addition of the new stack overflow check. It falls flat on
its face really early if that is enabled.

The box is totally dead before console is initialised, so I
don't have backtraces, I'll give that a shot with a serial
console later. In the meantime, acpi folks should probably
try testing with CONFIG_DEBUG_STACKOVERFLOW=y to see if they
hit the same problems I'm getting.

Back later..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
