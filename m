Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752967AbWKCNXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbWKCNXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbWKCNXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:23:52 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:18594 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752939AbWKCNXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:23:51 -0500
X-Sasl-enc: juYOd0covmdjqdetn/G4qGYgmVUcIKMg0sFlLd1/a1CZ 1162560230
Date: Fri, 3 Nov 2006 10:23:40 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Jean Delvare <khali@linux-fr.org>,
       davidz@redhat.com, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061103132340.GB4257@khazad-dum.debian.net>
References: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <znLIYxER.1162453921.3011900.khali@localhost> <454A306C.3050200@tmr.com> <000b01c6feb4$c340a580$0732700a@djlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c6feb4$c340a580$0732700a@djlaptop>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2006, Richard B. Johnson wrote:
> No known laptop bothers to do this. That's why the batteries fail at the
> most inoportune times and why it will decide to shut down when it feels
> like it, based totally upon some detected voltage drop when a disk-drive
> started.

Weird, I though the whole point behind a SBS hardware stack requiring
something fairly intelligent in the battery pack and allowing for (runtime
switchable!) Ah or Wh modes of operation was to allow vendors to do exactly
that: measure (V,A) permanently while the cells are above the safety cut-off
fuse level, and accumulate it...

Well, IBM embedded a microcontroller of some sort on every SBS ThinkPad
battery pack, and the ThinkPad reports battery data in Wh, so I expected it
to actually do the hard work to know how much energy is still left in the
pack...  especially given how much $$$ they want for the packs :-) I have no
idea of what software is really running inside the battery pack, of course,
so maybe the SBS battery EC just sits there doing something else instead of
taking real-time measurements of the battery charge (that wouldn't surprise
me too much...).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
