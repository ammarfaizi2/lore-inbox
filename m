Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760018AbWLCTUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760018AbWLCTUW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760028AbWLCTUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:20:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30642 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1760018AbWLCTUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:20:20 -0500
Subject: Re: [RFC] rfkill - Add support for input key to control wireless
	radio
From: Arjan van de Ven <arjan@infradead.org>
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <200612031936.34343.IvDoorn@gmail.com>
References: <200612031936.34343.IvDoorn@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 03 Dec 2006 20:20:18 +0100
Message-Id: <1165173618.3233.243.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-03 at 19:36 +0100, Ivo van Doorn wrote:
> +static int rfkill_open(struct input_dev *dev)
> +{
> +       ((struct rfkill_key*)(dev->private))->open_count++;
> +       return 0;
> +} 

Hi,

this open_count thing smells fishy to me; what are the locking rules for
it? What guarantees that the readers of it don't get the value changed
underneath them between looking at the value and doing whatever action
depends on it's value ?

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

