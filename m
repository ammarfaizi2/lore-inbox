Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWHHLGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWHHLGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWHHLGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:06:44 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:60405 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S964841AbWHHLGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:06:35 -0400
Message-ID: <44D8702D.1090005@namesys.com>
Date: Tue, 08 Aug 2006 15:06:21 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com> <20060803140344.GC7431@merlin.emma.line.org> <44D219F9.9080404@namesys.com> <20060807075744.GA8894@merlin.emma.line.org>
In-Reply-To: <20060807075744.GA8894@merlin.emma.line.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> [stripping Cc: list]
> 
> On Thu, 03 Aug 2006, Edward Shishkin wrote:
> 
> 
>>>What kind of forward error correction would that be,
>>
>>Actually we use checksums, not ECC. If checksum is wrong, then run
>>fsck - it will remove the whole disk cluster, that represent 64K of
>>data.
> 
> 
> Well, that's quite a difference...
> 
> 
>>Checksum is checked before unsafe decompression (when trying to
>>decompress incorrect data can lead to fatal things).
> 
> 
> Is this sufficient? How about corruptions that lead to the same checksum
> and can then confuse the decompressor? 


It is a multiplication of two unlikely events: fs corruption
and 32-hash collision. Paranoid people can assign zlib-based
transform plugin: afaik everything is safe there.


Is the decompressor safe in that
> it does not scribble over memory it has not allocated?
> 

yes

