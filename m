Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752717AbWKBH5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbWKBH5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbWKBH5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:57:52 -0500
Received: from zone4.gcu.info ([217.195.17.234]:986 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1752717AbWKBH5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:57:52 -0500
Date: Thu, 2 Nov 2006 08:52:01 +0100 (CET)
To: multinymous@gmail.com, xavier.bestel@free.fr
Subject: Re: [PATCH v2] Re: Battery class driver.
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <znLIYxER.1162453921.3011900.khali@localhost>
In-Reply-To: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: davidz@redhat.com, "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/31/2006, man with no name wrote:
> In the case at hand we have mWh and mAh, which measure different
> physical quantities. You can't convert between them unless you have
> intimate knowledge of the battery's chemistry and condition, which we
> don't.

You just need to know the voltage of the battery, what else?

> And it would be nice to also allow for power supply devices that use
> other, incompatible units like "percent" or "minutes" or "hand crank
> revolutions".

Do such batteries exist at the moment, or are you just speculating? I
don't quite see how a battery could report remaining energy in time
units, as power consumption varies over time. Hand crank revolutions
wouldn't be a very useful unit either, unless you know how much energy
a revolution provides, and then you can just convert it. Percent would
make some sense, but you can only express the remaining energy this way,
not the total. And if you know the total in mAh or mWh, you can multiply
by the percentage and you get the remaining energy in the same unit.

--
Jean Delvare
