Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318846AbSG0WpY>; Sat, 27 Jul 2002 18:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318848AbSG0WpX>; Sat, 27 Jul 2002 18:45:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22001 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318846AbSG0WpX>; Sat, 27 Jul 2002 18:45:23 -0400
Subject: RE: About the need of a swap area
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Austin Gonyou <austin@digitalroadkill.net>,
       vda@port.imtp.ilyichevsk.odessa.ua, Ville Herva <vherva@niksula.hut.fi>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <FJEIKLCALBJLPMEOOMECOEPGCPAA.b.lumpkin@attbi.com>
References: <FJEIKLCALBJLPMEOOMECOEPGCPAA.b.lumpkin@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jul 2002 01:03:16 +0100
Message-Id: <1027814596.21511.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-27 at 23:39, Buddy Lumpkin wrote:
> Why would you want to push *anything* to swap until you have to?

To reduce the amount of disk access
 
> Dirty filesystem pages have to be flushed to disk, it's just a question of

Clean ones do not. Dirty ones are also copied to disk but remain in
memory for reread events. They may also be deleted before being written.

> and it's pretty relative what "long unaccessed" means ..

In the Linux case the page cache is basically not discriminating too
much about what page is (and it may be several things at once - cache,
executing code and file data) just its access history.


