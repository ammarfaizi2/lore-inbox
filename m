Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318856AbSG0XKP>; Sat, 27 Jul 2002 19:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSG0XKP>; Sat, 27 Jul 2002 19:10:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59121 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318856AbSG0XKO>; Sat, 27 Jul 2002 19:10:14 -0400
Subject: RE: About the need of a swap area
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Austin Gonyou <austin@digitalroadkill.net>,
       vda@port.imtp.ilyichevsk.odessa.ua, Ville Herva <vherva@niksula.hut.fi>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <FJEIKLCALBJLPMEOOMECCEPJCPAA.b.lumpkin@attbi.com>
References: <FJEIKLCALBJLPMEOOMECCEPJCPAA.b.lumpkin@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jul 2002 01:28:09 +0100
Message-Id: <1027816089.21516.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 00:01, Buddy Lumpkin wrote:
> Are you implying that it should be looking for pages to swap out this whole
> time to free up more space for filesystem and executable pages purely based
> on lru? Have you done testing to prove that this is a better approach than
> setting a threshold of when to wake up the lru mechanism?

Not all the time - when there is pressure to find more pages. 

> Solaris keeps dirty pages after they have been flushed to their backing
> store, it's just when the system has to choose something to flush that it
> preferences filesystem over anonymous and executable, what's wrong with
> that?

Many of its pages are both file system and executable. Solaris shares
read-only pages between the caches and the mappings into process spaces.
I can understand favouring flushing mapped files because swap is
generally slower than restoring a file backed mapping

