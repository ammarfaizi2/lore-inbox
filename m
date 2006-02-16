Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWBPMQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWBPMQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030580AbWBPMQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:16:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63711 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030503AbWBPMQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:16:35 -0500
Subject: Re: Stuck creating sysfs hooks for a driver..
From: Arjan van de Ven <arjan@infradead.org>
To: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Cc: Greg KH <greg@kroah.com>, philippe.seewer@bfh.ch,
       linux-kernel@vger.kernel.org
In-Reply-To: <43F46319.9090400@designergraphix.com>
References: <43F2DE34.60101@designergraphix.com>
	 <20060215221301.GA25941@kroah.com>  <43F46319.9090400@designergraphix.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 13:16:28 +0100
Message-Id: <1140092189.4117.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also it's a relatively simple temperature sensor - it does not seem to 
> support hysteresis temperature, i/p voltages, etc. I'm saying all this 
> as the sysfs interface i envision is just a simple read-only hook: the 
> o/p value (after a little userspace massaging) is the temperature in 
> Celsius correct to 0.25 degrees. So it looks to me that this particular 
> driver necessitates a kind-of "custom" entry under /sys/class/hwmon with 
> it's own userspace support. 

try to avoid this!
It is very useful for EVERYONE to only have ONE interface to report such
temperatures. That way *all* applications will just work, and nobody
needs to do 5 to 50 different interfaces in their application.

Please try to see if it's possible to use the existing userspace
interface. Pretty please with sugar on top ;)


