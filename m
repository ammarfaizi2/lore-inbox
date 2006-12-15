Return-Path: <linux-kernel-owner+w=401wt.eu-S1752061AbWLOMRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbWLOMRH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 07:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWLOMRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 07:17:06 -0500
Received: from mail.axxeo.de ([82.100.226.146]:36850 "EHLO mail.axxeo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbWLOMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 07:17:05 -0500
X-Greylist: delayed 1055 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 07:17:04 EST
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: EEPROM infrastructure (was: [PATCH] eeprom_93cx6: Add write support)
Date: Fri, 15 Dec 2006 12:58:55 +0100
User-Agent: KMail/1.9.1
Cc: Ivo van Doorn <ivdoorn@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       Michael Wu <flamingice@sourmilk.net>, linux-kernel@vger.kernel.org,
       Ingo Oeser <ioe-lkml@rameria.de>
References: <200612131956.51000.IvDoorn@gmail.com> <20061213190651.GF26412@csclub.uwaterloo.ca>
In-Reply-To: <20061213190651.GF26412@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612151258.56213.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen schrieb:
> On Wed, Dec 13, 2006 at 07:56:50PM +0100, Ivo van Doorn wrote:
> > This patch addes support for writing to the eeprom,
> > this also moves some duplicate code into seperate functions.
> > 
> > Signed-off-by Ivo van Doorn <IvDoorn@gmail.com>
> 
> Thank you.  I will have a try with that to see if I can get that to work
> with the jsm driver.  Too bad the serial drivers don't have any
> geteeprom/seteeprom standard ioctl's the way ethtool does for network
> devices.

It might be even better to have eeprom writing infrastructure.

Many device types come with eeproms today and they implement
it per driver or subsystem. On embedded platforms these EEPROMs
might even be shared among different devices.

So it might be time to generalize this like we did with LEDs.

Any comments?

Regards

Ingo Oeser
