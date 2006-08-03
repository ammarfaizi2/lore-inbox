Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWHCPpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWHCPpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWHCPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:45:11 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:33199 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S964824AbWHCPpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:45:09 -0400
Message-ID: <44D219F9.9080404@namesys.com>
Date: Thu, 03 Aug 2006 19:44:57 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Hans Reiser <reiser@namesys.com>, ric@emc.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com> <20060803140344.GC7431@merlin.emma.line.org>
In-Reply-To: <20060803140344.GC7431@merlin.emma.line.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Tue, 01 Aug 2006, Hans Reiser wrote:
> 
> 
>>You will want to try our compression plugin, it has an ecc for every 64k....
> 
> 
> What kind of forward error correction would that be,


Actually we use checksums, not ECC. If checksum is wrong, then run
fsck - it will remove the whole disk cluster, that represent 64K of
data.


  and how much and
> what failure patterns can it correct? URL suffices.
> 

Checksum is checked before unsafe decompression (when trying to
decompress incorrect data can lead to fatal things). It can be
broken because of many reasons. The main one is tree corruption
(for example, when disk cluster became incomplete - ECC can not
help here). Perhaps such checksumming is also useful for other
things, I didnt classify the patterns..

Edward.
