Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWAPU20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWAPU20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWAPU20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:28:26 -0500
Received: from lizards-lair.paranoiacs.org ([216.158.28.252]:41968 "EHLO
	lizards-lair.paranoiacs.org") by vger.kernel.org with ESMTP
	id S1751208AbWAPU2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:28:25 -0500
Date: Mon, 16 Jan 2006 15:28:12 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Dave Jones <davej@redhat.com>, Adam Belay <ambx1@neo.rr.com>,
       Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060116202812.GA10215@paranoiacs.org>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adam Belay <ambx1@neo.rr.com>, Con Kolivas <kernel@kolivas.org>,
	ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060112221133.GA11601@neo.rr.com> <20060112230315.GO19827@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112230315.GO19827@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 18:03:15 -0500, Dave Jones wrote:
> As soon as that usb timer hits (every 250ms iirc) you'll bounce back out
> of any low-power state you may be in. It's a bit craptastic that we do
> this, even if we don't have any USB devices plugged in.

Is your USB controller an OHCI? If so, try reverting this patch:
<URL:http://marc.theaimsgroup.com/?l=linux-usb-devel&m=110313153001002&w=2>

Apparently some mfrs' OHCI controllers need this patch to function sanely,
but mine (in a Libretto L5) won't suspend after this change, and works
great without it.

HTH,
-
-Ben


-- 
Ben Slusky                      | The only "intuitive" inter-
sluskyb@paranoiacs.org          | face is the nipple. After
sluskyb@stwing.org              | that, it's all learned.
PGP keyID ADA44B3B              |               -Bruce Ediger
