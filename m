Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWH2MZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWH2MZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWH2MZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:25:45 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:41604 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751342AbWH2MZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:25:12 -0400
Message-ID: <44F43135.4070703@s5r6.in-berlin.de>
Date: Tue, 29 Aug 2006 14:21:09 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <20060829115138.GA32714@infradead.org>
In-Reply-To: <20060829115138.GA32714@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Aug 25, 2006 at 05:23:05PM +0100, David Howells wrote:
>> > >  config USB_STORAGE
>> > >  	tristate "USB Mass Storage support"
>> > > -	depends on USB
>> > > +	depends on USB && BLOCK
>> > 
>> > ditto.
>> 
>> ditto?
> 
> Same as above.  USB_STORAGE already selects scsi so it shouldn't need
> to depend on block.

David,
same with config IEEE1394_SBP2.

(sbp2 and usb-storage use one to two block layer symbols directly for
the single purpose to tune the SCSI request queue. I.e. they depend on
BLOCK just because they are SCSI drivers.)
-- 
Stefan Richter
-=====-=-==- =--- ===-=
http://arcgraph.de/sr/
