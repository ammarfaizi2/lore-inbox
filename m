Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUCUTqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 14:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCUTqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 14:46:13 -0500
Received: from pop.gmx.net ([213.165.64.20]:25563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261169AbUCUTqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 14:46:09 -0500
X-Authenticated: #21910825
Message-ID: <405DF09C.9060804@gmx.net>
Date: Sun, 21 Mar 2004 20:44:28 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Thomas Horsten <thomas@horsten.com>,
       Christophe Saout <christophe@saout.de>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <405DD9E2.4030308@pobox.com> <405DE18B.7090505@gmx.net> <405DE2B6.7060003@backtobasicsmgmt.com>
In-Reply-To: <405DE2B6.7060003@backtobasicsmgmt.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:
> Carl-Daniel Hailfinger wrote:
> 
>> - Would an EVMS plugin or a simple script calling dmsetup be the way to
>> go? If I go the dmsetup route, is there any chance to get partition
>> detection on top of the ATARAID for free (by calling another dm tool)?
> 
> 
> This was posted a while back; I don't know what the status of it being
> merged into util-linux is.
> 
> http://lwn.net/Articles/13958/


The two links below mention the same problems of partitions over dm:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107383495031133
http://marc.theaimsgroup.com/?l=linux-kernel&m=107384987212233

And here two links for partitions over md:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107401984323154
http://lkml.org/lkml/2003/11/13/182
And the patch to do partitions over md:
http://cgi.cse.unsw.edu.au/~neilb/patches/linux-devel/2.5/2004-02-03:03/006MdPartition

(Related to the problem mentioned earlier in this thread)
Christophe Saout seems to already have some prototype to handle ATARAID
devices in general:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107652932411321

Now the question is: How do we fit all of this together?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

