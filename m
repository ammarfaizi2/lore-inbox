Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUFLUJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUFLUJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUFLUJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:09:56 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:27290 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264913AbUFLUJy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:09:54 -0400
Message-ID: <40CB632B.2070706@blue-labs.org>
Date: Sat, 12 Jun 2004 16:10:19 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: sound driver (opti) spinlock bug, 2.6.7-rc3
Content-Type: multipart/mixed;
 boundary="------------070901050009030201080304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901050009030201080304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

pnp: the driver 'opti9xx' has been registered
pnp: match found with the PnP device '01:01.01' and the driver 'opti9xx'
pnp: match found with the PnP device '01:01.03' and the driver 'opti9xx'
sound/isa/opti9xx/opti92x-ad1848.c:428: 
spin_lock(sound/isa/opti9xx/opti92x-ad1848.c:cf40eea0) already locked by 
sound/isa/opti9xx/opti92x-ad1848.c/604
sound/isa/opti9xx/opti92x-ad1848.c:610: 
spin_unlock(sound/isa/opti9xx/opti92x-ad1848.c:cf40eea0) not locked
ALSA sound/isa/opti9xx/opti92x-ad1848.c:2174: no OPL device at 0x380-0x383
ALSA device list:
  #0: OPTi 82C931, 82C931 at 0x608, irq 10, dma 0&1
sound/isa/opti9xx/opti92x-ad1848.c:879: 
spin_lock(sound/isa/opti9xx/opti92x-ad1848.c:cf407fbc) already locked by 
sound/isa/opti9xx/opti92x-ad1848.c/1035
sound/isa/opti9xx/opti92x-ad1848.c:772: 
spin_lock(sound/isa/opti9xx/opti92x-ad1848.c:cf407fbc) already locked by 
sound/isa/opti9xx/opti92x-ad1848.c/879
sound/isa/opti9xx/opti92x-ad1848.c:888: 
spin_unlock(sound/isa/opti9xx/opti92x-ad1848.c:cf407fbc) not locked
sound/isa/opti9xx/opti92x-ad1848.c:1055: 
spin_unlock(sound/isa/opti9xx/opti92x-ad1848.c:cf407fbc) not locked
sound/isa/opti9xx/opti92x-ad1848.c:772: 
spin_lock(sound/isa/opti9xx/opti92x-ad1848.c:cf407fbc) already locked by 
sound/isa/opti9xx/opti92x-ad1848.c/939


--------------070901050009030201080304
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070901050009030201080304--
