Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967817AbWK3Bx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967817AbWK3Bx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967819AbWK3Bx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:53:27 -0500
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:63071 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S967817AbWK3Bx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:53:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=00fCyu4YIpXD3b6oYY0A3SZkF/hEqios0aTZFAaTmlEWkzdjQVTTXsefDEhGp0MFTLoz+OctRsF1GX2X6WSp5Ir5vr6zJ+HDWmfEeIS4aaKHwcuXmkPTNSmycvYdZBB2ZGH2VZlW9N9tAV16eVb30tW2sKo3OfHLCMpHvjsgQDc=;
X-YMail-OSG: qy4HZAwVM1mE5cPdsxgTI7xDR28vHY9hoePDOkxtpszD6HXvvpypvaWGlEMGXBERWRrORIJd5NIsfHGvW5d9lONL5ARpGM0CxKOZMxVq8t7MeIPd2IxgyOwsxfeP1oRc_JJCZuIfv.qBMb0-
Date: Wed, 29 Nov 2006 17:53:25 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: Infinite retries reading the partition table
To: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <994367.96477.qm@web31806.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Luben Tuikov <ltuikov@yahoo.com> wrote:

> Suppose reading sector 0 always reports an error,
> sense key HARDWARE ERROR.
> 
> What I'm observing is that the request to read sector 0,
> reading partition information, is retried forever, ad infinitum.
> 
> Does anyone have a patch to resolve this? (2.6.19-rc6)

Actually the device sends SK: MEDIUM ERROR, ASC: UNRECOVERED READ ERR,
but SCSI Core seems to retry reading the partition table (sector 0)
forever.

Anyone seen this and/or has a patch in their tree for it?

   Luben
P.S.  This is fairly straightforward to inject/test.

