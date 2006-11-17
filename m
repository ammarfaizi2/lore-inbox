Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424467AbWKQNnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424467AbWKQNnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424442AbWKQNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:43:40 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:37862 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1424383AbWKQNni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:43:38 -0500
Message-ID: <455DBC88.6040701@s5r6.in-berlin.de>
Date: Fri, 17 Nov 2006 14:43:36 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com> <20061116223721.GS8236@csclub.uwaterloo.ca>
In-Reply-To: <20061116223721.GS8236@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Thu, Nov 16, 2006 at 04:01:03PM -0600, Protasevich, Natalie wrote:
>> There are some port 80 cards that you can buy:
...
> Hmm, one of those on the PCI bus might work.  Or perhaps the parallel
> port will.  Of course if the problem is that somehow the PCI bus is
> locked up, then I won't get a message anywhere since all the busses are
> connected via PCI it seems.  I don't know if a PCI bus can lock up, but
> for now I was assuming anything was possible.

If the PCI bus itself isn't brought down, you could debug from remote
using Benjamin Herrenschmidt's Firescope on the remote node and a
FireWire card in the test machine. Once the ohci1394 driver was loaded,
the FireWire controller is able to read and write to the 32bit PCI
address range (and thus to system memory) without assistance of
interrupt handlers.
-- 
Stefan Richter
-=====-=-==- =-== =---=
http://arcgraph.de/sr/
