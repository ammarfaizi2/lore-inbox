Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTLDBZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbTLDBZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:25:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37802 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262925AbTLDBZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:25:27 -0500
Message-ID: <3FCE8CF5.4030006@pobox.com>
Date: Wed, 03 Dec 2003 20:25:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> With an encrypted filesystem, you can't do that. Or rather: you can do it
> if the filesystem is read-only, but you definitely CANNOT do it on
> writing. For writing you have to marshall the output buffer somewhere
> else (and quite frankly, it tends to become a lot easier if you can do
> that for reading too).
> 
> And that in turn causes problems. You get all kinds of interesting
> deadlock schenarios when write-out requires more memory in order to
> succeed. So you need to get careful. Reading ends up being the much easier
> case (doesn't have the same deadlock issues _and_ you could do it in-place
> anyway).


FWIW zisofs and ntfs have to do this too, since X on-disk compressed 
pages must be expanded to X+Y in-memory pages...

	Jeff



