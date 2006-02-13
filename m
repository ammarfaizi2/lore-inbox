Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWBMJ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWBMJ4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWBMJ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:56:30 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:53885 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751691AbWBMJ43 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:56:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WAteIFj9wzK63mam22DKKI26oR/8CGEDgG9QK09j0081rLtMUS6PDEJ8ErUVUyEPmmvpRZgd2JVDlJqStNhKU30Tj387Y9Id4xUHwyB7kayMQBImfrjZEgDbl88fAtHuuMybWCgwpaBByrb+FQFguXoAKUrivNn5uPTrpeM/kGQ=
Message-ID: <58cb370e0602130156k10dff232o46b46e7030a504ee@mail.gmail.com>
Date: Mon, 13 Feb 2006 10:56:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Seewer Philippe <philippe.seewer@bfh.ch>
Subject: Re: RFC: disk geometry via sysfs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43EC8FBA.1080307@bfh.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EC8FBA.1080307@bfh.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Seewer Philippe <philippe.seewer@bfh.ch> wrote:
> Hello all!

Hi!

> I don't want to start another geometry war, but with the introduction of
> the general getgeo function by Christoph Hellwig for all disks this
> simply would become a matter of extending the basic gendisk block driver.
>
> There are people out there (like me) who need to know about disk
> geometry. But since this is clearly post 2.6.16 I prefer to ask here
> before writing a patch...
>
> Q1: Yes or No?
> If no, the other questions do not apply

Yes?

> Q2: Where under sysfs?
> Either do /sys/block/hdx/heads, /sys/block/hdx/sectors, etc. or should
> there be a new sub-object like /sys/block/hdx/geometry/heads?

IMO /sys/block/hdx/sectors could be misleading
therefore /sys/block/hdx/geometry/ would be better

> Q3: Writable?
> Under some (weird) circumstances it would actually be quite nice to
> overwrite the kernels idea of a disks geometry. This would require a
> general function like setgeo. Acceptable?

Don't know.  Maybe you should make it into separate patch
(incremental to basic functionality) so it can be decided later.

Cheers,
Bartlomiej
