Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751949AbWG0TGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWG0TGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWG0TGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:06:15 -0400
Received: from 63-162-81-169.lisco.net ([63.162.81.169]:27567 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751949AbWG0TGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:06:14 -0400
Message-ID: <44C90EA2.4000902@slaphack.com>
Date: Thu, 27 Jul 2006 14:06:10 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060530)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Pavel Machek <pavel@ucw.cz>, Hans Reiser <reiser@namesys.com>,
       Matthias Andree <matthias.andree@gmx.de>, lkml@lpbproductions.com,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com> <20060726131709.GB5270@ucw.cz> <44C8FE41.5040909@garzik.org>
In-Reply-To: <44C8FE41.5040909@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Pavel Machek wrote:
>> Hi!
>>
>>>> of the story for me. There's nothing wrong about focusing on newer 
>>>> code,
>>>> but the old code needs to be cared for, too, to fix remaining issues
>>>> such as the "can only have N files with the same hash value".
>>> Requires a disk format change, in a filesystem without plugins, to 
>>> fix it.

> A filesystem WITH plugins must still handle the standard Linux 
> compatibility stuff that other filesystems handle.
> 
> Plugins --do not-- mean that you can just change the filesystem format 
> willy-nilly, with zero impact.

They --do-- mean that you can change much of the filesystem behavior 
without requiring massive on-disk changes or massive interface changes.

After all, this is how many FUSE plugins work -- standard FS interface, 
usually uses another standard FS as storage, but does crazy things like 
compression, encryption, and other transformations in between.
