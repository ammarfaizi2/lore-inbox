Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277210AbRJQU7Q>; Wed, 17 Oct 2001 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277208AbRJQU7G>; Wed, 17 Oct 2001 16:59:06 -0400
Received: from hermes.toad.net ([162.33.130.251]:42472 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S277206AbRJQU6x>;
	Wed, 17 Oct 2001 16:58:53 -0400
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
From: Thomas Hood <jdthood@mail.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: "Steven A. DuChene" <sduchene@mindspring.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3BCDAC10.A7F40982@t-online.de>
In-Reply-To: <1003288485.14282.100.camel@thanatos>
	<20011017041014.B2015@lapsony.mydomain.here> 
	<3BCDAC10.A7F40982@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 17 Oct 2001 16:58:33 -0400
Message-Id: <1003352314.1188.30.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-17 at 12:04, Gunther Mayer wrote:
> i2c-piix4 has to be taught to ignore PNP0c0x reservations.
> 
> PNP0C02 means "mainboard resource" and obviously i2c-piix4
> would like to use it, so it should make use of it's knowledge.
> 
> As "mainboard resouce" is very generic we must reserve it
> to protect against mapping other addresses over it.

Your approach would work.  But ...

Alan has said that the thing to do is mark these resources
as extant but unused.  I presume one does this by calling
request_resource with appropriate flags [un]set.

Thomas

