Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTIARH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTIARH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:07:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55720 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263023AbTIARHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:07:54 -0400
Message-ID: <3F537CDD.3040809@pobox.com>
Date: Mon, 01 Sep 2003 13:07:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Christoph Hellwig <hch@infradead.org>,
       Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
       tigran@aivazian.fsnet.co.uk
Subject: Re: dontdiff for 2.6.0-test4
References: <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com> <20030901163958.A24464@infradead.org> <20030901162244.GA1041@mars.ravnborg.org>
In-Reply-To: <20030901162244.GA1041@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Sep 01, 2003 at 04:39:58PM +0100, Christoph Hellwig wrote:
> 
>>>I have updated dontdiff in the usual place:
>>>  http://www.moses.uklinux.net/patches/dontdiff
>>>/usr/src/linux/Documentation/SubmittingPatches
>>
>>Btw, what about putting this somewhere in the kernel tree?
> 
> 
> I do not like dontdiff to be part of the kernel tree.
> What is included in dontdiff is redundant information already known
> by kbuild. Effectively dontdiff should not list any files that would
> not be removed during a "make mrproper".


This is not exactly true.

dontdiff must know about many things that 'make mrproper' need not care 
about:

	files with ".bak" suffix
	files with "~" suffix
	BitKeeper, CVS, RCS, SCCS directories

etc.

