Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272557AbTHFVJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272559AbTHFVJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:09:13 -0400
Received: from [64.140.61.244] ([64.140.61.244]:13190 "EHLO diva.home")
	by vger.kernel.org with ESMTP id S272557AbTHFVJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:09:12 -0400
From: Michael Driscoll <fenris@ulfheim.net>
Organization: FFW/CO
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Multiple symbols same address in vmlinux map file? huh?
Date: Wed, 6 Aug 2003 15:09:01 -0600
User-Agent: KMail/1.5.3
References: <1060177192.2866.11.camel@pussy.bemac.com> <Pine.LNX.4.53.0308061000280.9051@chaos>
In-Reply-To: <Pine.LNX.4.53.0308061000280.9051@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308061509.01206.fenris@ulfheim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 08:32, Richard B. Johnson wrote:
> On Wed, 6 Aug 2003, Andy Winton wrote:
> > nm vmlinux-2.4.18-14  | awk 'BEGIN{oldval=01;} { if ($1==oldval) {
> > if(plast) { print "\n"; print oldrow;} print $0; plast=0} else plast=1;
> > oldrow=$0; oldval=$1}' - | more

[snip]

> c01fd9c0 D i8259A_lock
> c01fd9e0 d i8259A_irq_type
>
> These are (correctly) at different addresses, but the static
> structure is still visible, which must not happen! So, you
> have certainly discovered something that's not right. Perhaps
> the 'd' stuff is "really" not visible? If so, what 'th..???

In nm(1) output, uppercase symbol types means the name is externally 
available, lowercase symbol means it is local.

Even if an object is local, the object file still knows its name (for ELF, 
anyways).  Finding local "static" variables would be very annoying otherwise, 
for porting code to a threaded application :)

-- 
Michael Driscoll, fenris@ulfheim.net
"A noble spirit embiggens the smallest man" -- J. Springfield
