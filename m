Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTEFJKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTEFJKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:10:42 -0400
Received: from www.tammen.de ([62.225.14.106]:47884 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id S262464AbTEFJKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:10:41 -0400
From: Heinz Ulrich Stille <hus@design-d.de>
Organization: design_d gmbh
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: Tyans S2460 hang with i2c
Date: Tue, 6 May 2003 11:22:58 +0200
User-Agent: KMail/1.5
References: <20030505114246.GA673@gallifrey> <20030505181831.GF673@gallifrey> <20030505182827.GB1826@kroah.com>
In-Reply-To: <20030505182827.GB1826@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200305061122.58819.hus@design-d.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 May 2003 20:28, Greg KH wrote:
> If after doing that, it says you have the adm1021 and lm75 chips and
> they work properly on 2.4, please let me know and I'll try to track down
> what's changed on 2.5.

The Tiger MP and MPX need (apart from i2c-dev) w83781d and i2c-amd756.
I'm using kernel 2.4.20 with the lm_sensors modules; the w83781d needs
a special patch (to recognize two subclients, iirc). The proper init
sequence is:
modprobe i2c-dev
modprobe w83781d init=0 force_subclients=0,0x2c,0x4a,0x4b \
	motherboard=tyan_s246x
modprobe i2c-amd756

Up till now I've had no luck with kernel 2.5.x, not that I've really tried.
Among other problems, I didn't get lm_sensors to compile. This may be fixed
by now, but I'm happy with 2.4.20 and haven't got too much time.

MfG, Ulrich

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400463 / Fax: +49-541-9400450
design_d gmbh / Lortzingstr. 2 / 49074 Osnabrück / www.design-d.de

