Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131833AbRAOXsd>; Mon, 15 Jan 2001 18:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbRAOXsX>; Mon, 15 Jan 2001 18:48:23 -0500
Received: from mailgate2.zdv.Uni-Mainz.DE ([134.93.8.57]:30340 "EHLO
	mailgate2.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S131936AbRAOXsP>; Mon, 15 Jan 2001 18:48:15 -0500
Date: Tue, 16 Jan 2001 00:47:54 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jack Hammer <jhammer@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Slot Number Question
Message-ID: <20010116004754.A14902@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Jack Hammer <jhammer@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <OF164CE1E4.54391C01-ON852569D5.0067049B@raleigh.ibm.com> <Pine.LNX.3.95.1010115145101.2779A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.3.95.1010115145101.2779A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Jan 15, 2001 at 03:22:58PM -0500
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 03:22:58PM -0500, Richard B. Johnson wrote:
> 
> In any case, there is no way to correlate the device number with a
> PC connector slot just as there is no way to find out which of the
> 4 INT lines go to these connectors. The BIOS vendor only knows for
> sure, and since BIOSes are not updated as often as boards, even the
> BIOS is often incorrect.

Well actually there seems to be a way to do this. Quoting "System Management
BIOS Reference Specification" v2.3.1 (p.51):

   3.3.10 System Slots (Type 9)

   The information in this structure defines the attributes of a system
   slot. One structure is provided for each slot in the system.

And later in table 3.3.10.5 (p.53):

   Identifies the value present in the Slot Number field of the PCI Interrupt
   Routing Table entry that is associated with this slot, in offset 09h [...]

   Software can determine the PCI bus number and device associated with the
   slot by matching the "Slot ID" to an entry in the routing table... and
   ultimately determine what device is present in that slot.

Right now Linux' SMBIOS implementation use only the first 3 tables to determine
the manufacturer of system and BIOS to blacklist known buggy APM/ACPI
implementations.  Since i have the SMBIOS specs at hand i will have a lot.
Is there a PCI spec available on the net? www.pcisig.org asks for a password
when you try to download the specs... (don't you just love "secret" standards?)

Yours,
  Dominik Kubla
-- 
  Sign me!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
