Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVKSAfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVKSAfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVKSAfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:35:07 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:53481 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751130AbVKSAfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:35:05 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] optional use "gzip --rsyncable" for bzImage
Date: Sat, 19 Nov 2005 00:34:55 +0000
User-Agent: KMail/1.9
Cc: "Ph. Marek" <philipp.marek@bmlv.gv.at>, linux-kernel@vger.kernel.org
References: <200511161408.49287.philipp.marek@bmlv.gv.at> <20051116175413.208d27db.akpm@osdl.org>
In-Reply-To: <20051116175413.208d27db.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511190034.55328.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 01:54, Andrew Morton wrote:
> "Ph. Marek" <philipp.marek@bmlv.gv.at> wrote:
> >  As (at least in debian) gzip has the "--rsyncable" parameter included,
> >  I'd like to suggest this patch to (configurable) use this for bzImage
> > creation.
>
> I'd doubt if this works with a compressed a.out.  Most changes one would
> make to a kernel at the source level will cause changes all over the
> generated binary, so rsync will send the whole compressed file anyway.
>
> For example, a few-byte change in size of a function will cause a huge
> number of `call xxxxxxxx' opcodes to turn into `call xxxxxxxx+N'.
>
> So I'll need some convincing.  But even if convinced, this seems like an
> exceedingly obscure thing that not many people would be interested in.

Sounds like a patch for the debian kernel team, since GNU's latest alpha gzip 
version doesn't support --rsyncable.

[alistair] 00:34 [~] gzip --rsyncable
gzip: unrecognized option `--rsyncable'
gzip 1.3.5

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
