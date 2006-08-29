Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWH2ORK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWH2ORK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWH2ORK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:17:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56995 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964986AbWH2ORH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:17:07 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F44B8D.4010700@s5r6.in-berlin.de>
Date: Tue, 29 Aug 2006 16:13:33 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-fsdevel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de>
In-Reply-To: <44F44639.90103@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> If SCSI is set to "N", then any menu items which depend on SCSI are not 
> visible anymore.
[...]
> If "select" cannot be fixed or is not en vogue for any other reason, the 
> configuration tools need to be improved otherwise, so that users are 
> guided to options like USB_STORAGE and IEEE1394_SBP2 when SCSI or other 
> "foreign" options were disabled.

An easy but crude fix would be to add an according hint at the help text 
of the immediately superordinate config option. E.g. at IEEE1394: "Also 
enable SCSI support to be able to switch on SBP-2 support (IEEE 1394 
protocol e.g. for storage devices)." But this is extremely ugly /1./ 
because it would litter help texts of generic options with redundant 
information about specific options and /2./ because it requires users to 
find and read help texts in order to convince the configurator to make 
options visible.
-- 
Stefan Richter
-=====-=-==- =--- ===-=
http://arcgraph.de/sr/
