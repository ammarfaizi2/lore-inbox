Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271734AbTHDNYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271731AbTHDNYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:24:12 -0400
Received: from main.gmane.org ([80.91.224.249]:65189 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271734AbTHDNXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:23:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: 2.6.0-test2, sensors and sysfs
Date: Thu, 31 Jul 2003 20:52:22 +0400
Message-ID: <20030731205222.0f1521f1.vsu@altlinux.ru>
References: <1059669362.23100.12.camel@laurelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
X-Newsreader: Sylpheed version 0.9.4cvs2 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 2003 18:36:02 +0200
Flameeyes <daps_mls@libero.it> wrote:

> I need to know the system temperature for check some stability problems,
> under 2.4 I was using lm_sensors patches, using i2c-viapro as i2c bus
> and via686a as chip driver (I'm using a via 686 southbridge, see the
> lspci output attached), and I was able to use sensors for see the
> temperatures.
> With the 2.6.0-test2 (and all earlier kernels since 2.5.69), I'm not
> able anymore to see the temperature, nor with sensor (or libsensor
> library) nor with sysfs (that, AFAIK, should be the new method to access
> sensors data).
> The only i2c device that I can see in the sysfs is the tuner of my
> bt-based tv card.
> I tried either with i2c-viapro and via686a as modules, and built-in in
> kernel. Nothing	changes. Also dmesg doesn't output anything.
> I have missed something?

Currently (2.6.0-test2) i2c-viapro and via686a don't work together -
you can use only one of them. This is because they want to work with
the same PCI device - and having multiple drivers for one device is
not allowed for obvious reasons.

This issue is already known to the lm_sensors developers.

So you will need to remove i2c-viapro for now (but leave i2c-isa);
then you will see the via686a sensors again.

