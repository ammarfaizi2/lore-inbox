Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTJPS1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJPS1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:27:44 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:55681 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262973AbTJPS1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:27:43 -0400
Date: Thu, 16 Oct 2003 19:28:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Cc: val@nmt.edu
In-Reply-To: <20031016172930.GA5653@work.bitmover.com>
References: <1066163449.4286.4.camel@Borogove>
 <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com>
 <20031016162926.GF1663@velociraptor.random>
 <20031016172930.GA5653@work.bitmover.com>
Subject: Re: Transparent compression in the FS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Larry McVoy <lm@bitmover.com>:
> On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> > Josh and others should take a look at Plan9's venti file storage method 
> > -- archival storage is a series of unordered blocks, all of which are 
> > indexed by the sha1 hash of their contents.  This magically coalesces 
> > all duplicate blocks by its very nature, including the loooooong runs of 
> > zeroes that you'll find in many filesystems.  I bet savings on "all 
> > bytes in this block are zero" are worth a bunch right there.
> 
> The only problem with this is that you can get false positives.  Val Hensen
> recently wrote a paper about this.  It's really unlikely that you get false
> positives but it can happen and it has happened in the field.  

Surely it's just common sense to say that you have to verify the whole
block - any algorithm that can compress N values into <N values is
lossy by definition.  A mathematical proof for that is easy.

John.
