Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTJPQlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTJPQlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:41:52 -0400
Received: from gate.corvil.net ([213.94.219.177]:3080 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S263024AbTJPQlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:41:51 -0400
Message-ID: <3F8ECA3E.4030208@draigBrady.com>
Date: Thu, 16 Oct 2003 17:41:34 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, Erik Mouw <erik@harddisk-recovery.com>,
       Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
In-Reply-To: <20031016162926.GF1663@velociraptor.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Hi Jeff,
> 
> On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> 
>>Josh and others should take a look at Plan9's venti file storage method 
>>-- archival storage is a series of unordered blocks, all of which are 
>>indexed by the sha1 hash of their contents.  This magically coalesces 
>>all duplicate blocks by its very nature, including the loooooong runs of 
>>zeroes that you'll find in many filesystems.  I bet savings on "all 
>>bytes in this block are zero" are worth a bunch right there.
> 
> I had a few ideas on the above.
> 
> if the zero blocks are the problem, there's a tool called zum that nukes
> them and replaces them with holes. I use it sometime, example:

Yes post processing with this tool is useful.
Also note gnu cp (--sparse) inserts holes
in files also.

I thought a bit about this also and thought
that in general the overhead of instant block/file
duplicate merging is not worth it. Periodic
post processing with a merging tool is
much more efficient IMHO. Of course this is
now only possible at the file level, but this
is all that generally useful I think. I guess
it's appropriate to plug my merging tool here :-)
http://www.pixelbeat.org/fslint

Pádraig.

