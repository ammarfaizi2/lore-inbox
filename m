Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269358AbUICO2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbUICO2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUICO2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:28:18 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:9091 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S269358AbUICO1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:27:54 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Stark <gsstark@mit.edu>, Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>
	<87u0ugt0ml.fsf@stark.xeocode.com>
	<1094209696.7533.24.camel@localhost.localdomain>
In-Reply-To: <1094209696.7533.24.camel@localhost.localdomain>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 03 Sep 2004 10:27:19 -0400
Message-ID: <87d613tol4.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Gwe, 2004-09-03 at 05:52, Greg Stark wrote:
> > I get the same message and the same basic symptom -- any process touching the
> > bad disk goes into disk-wait for a long time. But whereas before as far as I
> > know they never came out, now they seem to come out of disk-wait after a good
> > long time. But then maybe I just never waited long enough with 2.6.6.
> 
> This looks hopeful. You are now seeing the IDE layer error dump. Right
> now it doesn't decode the LBA block number although that data is
> available in the taskfile so I can knock up a test patch for you to try
> if you want.

Well I still have a problem. It seems once this occurs that *every* further
access generates the error. Even directories that I had previously been able
to list fail.

So while my machine isn't crippled once this happens, I still can't proceed
with the recovery.

And they seem to take 12 minutes to fail. I guess that indicates they were
either trying to do 24 blocks of readahead, or some combination of readahead
and retries from a higher layer.

-- 
greg

