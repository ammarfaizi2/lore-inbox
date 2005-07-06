Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVGFV7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVGFV7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVGFVzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:55:08 -0400
Received: from buffy.riseup.net ([69.90.134.155]:50816 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S262183AbVGFVxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:53:06 -0400
Date: Wed, 6 Jul 2005 23:55:57 +0200
From: st3@riseup.net
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedstep-centrino on dothan
Message-ID: <20050706235557.0c122d33@horst.morte.male>
In-Reply-To: <20050706211159.GF27630@redhat.com>
References: <20050706112202.33d63d4d@horst.morte.male>
	<42CC37FD.5040708@tmr.com>
	<20050706211159.GF27630@redhat.com>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005 17:11:59 -0400
Dave Jones <davej@redhat.com> wrote:

> This can't be done safely through any other means than ACPI right now.
> It needs to know intimate things about which VID line is wired to what,
> which is board specific.

I don't think it's related to 'which VID line is wired to what': this isn't
board specific, as it's given in datasheets provided by Intel (6 pins, etc).
The only issue is that there are four different versions of Dothan CPUs for
A1, A2, B0, B1, C0 steppings. There is only one version for C1 stepping. For
those different versions, Intel provides different typical voltage ranges.
For example, in read a post by Michael Clark in which he claims his IBM T42
has VID#A version of Dothan 745. I read ACPI tables on my laptop (Toshiba
Satellite A50, with Dothan 715) and I saw I got a VID#A version of Dothan
715 (is there somebody around with some other versions?).

Additionally, for lower frequencies VID#{A,B,C,D,E} voltages are the same.
So I ask: wouldn't it be good to find a way to add some lower frequencies,
while still reading ACPI tables for the other ones? Or to make profiles
configurable as a module parameter (as boot)? My problem isn't really ACPI,
but rather that one can't use lower and very useful frequencies.

Moreover, we could provide built-in tables for C1 stepping.


--
ciao
st3

