Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUEELUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUEELUx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUEELUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:20:53 -0400
Received: from gizmo02bw.bigpond.com ([144.140.70.12]:28593 "HELO
	gizmo02bw.bigpond.com") by vger.kernel.org with SMTP
	id S264542AbUEELUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:20:33 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Allen Martin" <AMartin@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Wed, 5 May 2004 21:24:55 +1000
User-Agent: KMail/1.5.1
Cc: "Len Brown" <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405052124.55515.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 May 2004 08:09, Allen Martin wrote:
> I'm happy to be able to make this information public to the Linux
> community.  This information has been previously released to BIOS /
> board vendors as an appnote, but in the interest of getting a workaround
> into the hands of users the quickest we're making it public for possible
> inclusion into the Linux kernel.
> 
<snip>

Thank you very much Allen for being involved in linux development.
Obsolecense is the best ending a temporary workaround could have.

I think I have found the problem with the Albatron KM18G-pro Mobos I have been
using.

They can't see through their Windows.??!@@#$$%%&*&

ML1-0505-19 Re: Cause of lockups with KM-18G Pro is incorrect pci reg values in bios -please update bios

From: 
"dr.pro" <dr.pro@albatron.com.tw>

To: 
<ross@datscreative.com.au>

Date: 
Today 17:38:08

  Dear Ross,

  Thank you very much for contacting Albatron technical support.

  KM18G Pro has been proved under Windows 98SE/ME/2000/XP but Linux, so you
may encounter problems with it under Linux. We suggest you use Windows
98SE/ME/2000/XP for the stable performance. Sorry for the inconvenience and
please kindly understand it.

  Please let us know if you have any question.

  Best regards,
  Dr.Pro
  ----- Original Message ----- 
  From: "Ross Dickson" <ross@datscreative.com.au>
  To: <dr.pro@albatron.com.tw>
  Sent: Tuesday, May 04, 2004 8:19 PM
  Subject: Cause of lockups with KM-18G Pro is incorrect pci reg values in
bios -please update bios


  > Greetings,
  >
  > The following is required for Linux to function correctly on your KM-18G
Pro.
  >
  > Allen Martin of Nvidia explains.
  >
  > I'm happy to be able to make this information public to the Linux
  > community.  This information has been previously released to BIOS /
  > board vendors as an appnote, but in the interest of getting a workaround
  > into the hands of users the quickest we're making it public for possible
  > inclusion into the Linux kernel.
  >
  >
  > Problem:
  > C1 Halt Disconnect problem on nForce2 systems
  >
  > Description:
  > A hang is caused when the CPU generates a very fast CONNECT/HALT cycle
  > sequence.
  >
  > Workaround:
  > Set the SYSTEM_IDLE_TIMEOUT to 80 ns. This allows the state-machine and
  > timer to return to a proper state within 80 ns of the CONNECT and probe
  > appearing together.
  >
  > Since the CPU will not issue another HALT within 80 ns of the initial
  > HALT, the failure condition is avoided.
  >
  > This will require changing the value for register at bus:0 dev:0 func:0
  > offset 6c.
  >
  > Chip   Current Value   New Value
  > C17       1F0FFF01     1F01FF01
  > C18D      9F0FFF01     9F01FF01
  >
  > Northbridge chip version may be determined by reading the PCI revision
  > ID (offset 8) of the host bridge at bus:0 dev:0 func:0.  C1 or greater
  > is C18D.
  >
  > Regards
  > Ross Dickson
  >
  >

