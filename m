Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313784AbSDHXKy>; Mon, 8 Apr 2002 19:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313785AbSDHXKx>; Mon, 8 Apr 2002 19:10:53 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46764 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313784AbSDHXKx>;
	Mon, 8 Apr 2002 19:10:53 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 8 Apr 2002 23:10:43 GMT
Message-Id: <UTC200204082310.XAA559533.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: sddr09.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This evening I cleaned up sddr09.c, and after some playing
succeeded in writing to a SM card.
Remains the question: does anyone have docs for this thing?

(The "read control" command gives 64 bytes for each 16kB block.
The last 48 look like junk. The first 16 either are all zero,
or start with six FF bytes followed by two groups of five bytes.
The first two bytes of both groups of five are equal, and
describe the PBA <-> LBA correspondence.
I do not know what the final three bytes of both groups mean.
They have five nybbles of even parity and one nybble that ends
in two 1 bits.
What is the purpose of this PBA <-> LBA mapping?
To avoid bad blocks? Or is rewriting a sector much slower
than relocating it and writing a fresh one?
I invented a "write_data" command, but have not yet tried
to do a "write_control".)

Andries
