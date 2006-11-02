Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752850AbWKBNy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbWKBNy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbWKBNy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:54:29 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60893 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752850AbWKBNy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:54:27 -0500
X-Sasl-enc: Bu26rycjdlbZjz5m5k+7vzDw29cFGWlNuQj/TcmPXg2Z 1162475667
Date: Thu, 2 Nov 2006 10:54:17 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: multinymous@gmail.com, xavier.bestel@free.fr, davidz@redhat.com,
       Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061102135417.GC15184@khazad-dum.debian.net>
References: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <znLIYxER.1162453921.3011900.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <znLIYxER.1162453921.3011900.khali@localhost>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2006, Jean Delvare wrote:
> On 10/31/2006, man with no name wrote:
> > In the case at hand we have mWh and mAh, which measure different
> > physical quantities. You can't convert between them unless you have
> > intimate knowledge of the battery's chemistry and condition, which we
> > don't.
> 
> You just need to know the voltage of the battery, what else?

The error goes way up when you do such calculations.  Not that most battery
hardware reports SBS Error margins right, but still...

So doing conversions is not a good idea unless it is from Ah to Coulombs or
something else like that which is an exact conversion.

In ThinkPads, you just need to compare what the various "let's calculate it"
applets say, and the output of tp_smapi (gets remanining time data directly
from the hardware) to see which one is more accurate :-)  And the difference
is often quite expressive.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
