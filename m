Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQLRVX0>; Mon, 18 Dec 2000 16:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLRVXS>; Mon, 18 Dec 2000 16:23:18 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:63705 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129930AbQLRVXA>; Mon, 18 Dec 2000 16:23:00 -0500
Date: Mon, 18 Dec 2000 20:52:31 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test13pre3ac1
Message-ID: <20001218205231.M1039@redhat.com>
In-Reply-To: <E14868l-00064b-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14868l-00064b-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 18, 2000 at 07:40:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 07:40:03PM +0000, Alan Cox wrote:

> o	Mark the parport fifo code as experimental	(Tim Waugh)

Needs this:

--- linux-2.4.0test13pre3-ac1/drivers/parport/Config.in	Mon Dec 18 20:45:54 2000
+++ linux-2.4.0-test13-pre3+/drivers/parport/Config.in	Mon Dec 18 16:56:36 2000
@@ -12,8 +12,8 @@
 if [ "$CONFIG_PARPORT" != "n" ]; then
    dep_tristate '  PC-style hardware' CONFIG_PARPORT_PC $CONFIG_PARPORT
    if [ "$CONFIG_PARPORT_PC" != "n" ]; then
-      bool '    Use FIFO/DMA if available (EXPERIMENTAL)' CONFIG_PARPORT_PC_FIFO
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+         bool '    Use FIFO/DMA if available (EXPERIMENTAL)' CONFIG_PARPORT_PC_FIFO
          bool '    SuperIO chipset support (EXPERIMENTAL)' CONFIG_PARPORT_PC_SUPERIO
       fi
    fi

Tim.
*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
