Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRBGMSH>; Wed, 7 Feb 2001 07:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBGMR6>; Wed, 7 Feb 2001 07:17:58 -0500
Received: from monza.monza.org ([209.102.105.34]:9995 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129393AbRBGMRu>;
	Wed, 7 Feb 2001 07:17:50 -0500
Date: Wed, 7 Feb 2001 04:16:31 -0800
From: Tim Wright <timw@splhi.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: hotplugging with regular PCI cards
Message-ID: <20010207041631.A14241@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <200102070608.WAA08283@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102070608.WAA08283@baldur.yggdrasil.com>; from adam@yggdrasil.com on Tue, Feb 06, 2001 at 10:08:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,
I saw the same demo. It's not the machine as such that's interesting.
The hotplug is achieved because of the chipset support. In fact the Compaq
chipset that supports hotplug PCI is used in quite a few of the IBM Netfinity
machines, and, I'm sure, many other servers. I'm going to be testing their
code on the Netfinities that I have access to shortly, but see no reason to
believe that it shouldn't work. In fact it would be good if anybody with
machines using the Compaq hotplug PCI chips would test the code.

As you mention, there is driver work needed, both the change you mention
and to make sure that all the drivers are using the newer 2.4 PCI
infrastructure in the first place (the hotplug support relies on this).

Regards,

Tim

On Tue, Feb 06, 2001 at 10:08:06PM -0800, Adam J. Richter wrote:
> 	I saw an interesting demonstration at LinuxWorld last week.
> Compaq had a machine that did hot plugging with regular PCI cards (not
> Compact PCI).  If anyone out there is familiar with this machine,
> I would be interested in knowing what the status is on getting
> the support for that backplain integrated into the stock kernels.
> 
> 	When that occurs, that will be yet another reason to treat all
> new style PCI drivers as potentially hot pluggable, even if those cards
> are not currently available in a CardBus or CompactPCI form, and in
> particular to change all of the xxx_pci_tbl declarations in PCI
> drivers that are currently marked as __initdata back to __devinitdata.
> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
