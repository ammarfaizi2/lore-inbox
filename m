Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWHIPsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWHIPsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWHIPsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:48:39 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:40876 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751052AbWHIPsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:48:38 -0400
Message-ID: <44DA03D1.1000100@slaphack.com>
Date: Wed, 09 Aug 2006 11:48:33 -0400
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Hans Reiser <reiser@namesys.com>, Edward Shishkin <edward@namesys.com>,
       Matthias Andree <matthias.andree@gmx.de>, ric@emc.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com> <20060803140344.GC7431@merlin.emma.line.org> <44D219F9.9080404@namesys.com> <44D231DF.1080804@namesys.com> <44D37E1B.1040109@namesys.com> <44D3ECB5.1060106@namesys.com> <44D66ADD.6020007@namesys.com> <44D99F96.4090804@namesys.com> <Pine.LNX.4.61.0608091352440.23404@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608091352440.23404@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> Yes, it looks like a business of node plugin, but AFAIK, you
>>> objected against such checks:
>> Did I really?  Well, I think that allowing users to choose whether to
>> checksum or not is a reasonable thing to allow them.  I personally would
>> skip the checksum on my computer, but others....
>>
>> It could be a useful mkfs option....
> 
> It should preferably a runtime tunable variable, at best even
> per-superblock and (overriding the sb setting), per-file.

Sounds almost exactly like a plugin.  And yes, that would be the way to 
do it, especially considering some files will already have internal 
consistency checking -- just as we should allow direct disk IO to some 
files (no journaling) when the files in question are databases that do 
their own journaling.
