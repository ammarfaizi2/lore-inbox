Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVGKJnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVGKJnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVGKJnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:43:09 -0400
Received: from starsky.19inch.net ([80.1.73.116]:31915 "EHLO
	starsky.19inch.net") by vger.kernel.org with ESMTP id S261524AbVGKJnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:43:08 -0400
Date: Mon, 11 Jul 2005 10:42:26 +0100 (BST)
From: Paul Sladen <thinkpad@paul.sladen.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Userspace accelerometer
 viewer)
In-Reply-To: <42C7A3B2.4090502@linuxwireless.org>
Message-ID: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
X-GPG-Key: DSA/E90CFA24
X-message-flag: Please use plain text when replying--not HTML.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Alejandro Bonilla wrote:
> PLEASE read the following article, it has the data of a guy that made a 
> driver in IBM for Linux and he described the driver he made.
> http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html

Yesterday evening, I used my time here at Debconf5 constructively!  ;-)

  http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-viewer.jpg    (43kB)
  http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-lid-shut.jpg  (27kB)

The sensor gives us two 10-bit AD values (corresponding to 0..1 volts on the
ADI chip), temperature (Celsius) and three status bits indicating:

  * lid open/closed
  * keyboard activity
  * nipple movement

On the X40 I borrowed (thanks Robert McQueen), at rest the outputs hover
around 512 (0x200).  Gravity is supposed to fall off in a sine-wave during
rotation, but I found that:

  theta = (N - 512) * 0.5

provides a surprisingly good approximation for pitch/roll values in degrees
in the range (-90..+90) so I think the sensor can do ~= +/-2.5G .

  http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-screenshot.png (9kB)

	-Paul

PS.  Coincidently, the name of the machine I borrowed is 'theta'...
-- 
Mostly it snows here.  Helsinki, FI



