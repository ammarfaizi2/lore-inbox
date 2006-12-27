Return-Path: <linux-kernel-owner+w=401wt.eu-S932820AbWL0NpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932820AbWL0NpF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWL0NpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:45:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:6854 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbWL0NpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:45:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=V0wNNbBB86NOW7ZH9LPOzbQCeVMst6t19zRs4akJgRaquK+go5W03Fd3vtnC6o+iKGryyvbCdU/07WhvrgOxtrKRrIqkC5Ys1tlkdJkxUC+k9kUYAfZYousqfBj1zleHz0uMg1gX19E63L/YFGxQCvXOUbRQIS8i8493V0fJ4G0=
Message-ID: <459278D4.6060005@gmail.com>
Date: Wed, 27 Dec 2006 22:44:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>,
       David Shirley <tephra@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SATA DMA problem (sata_uli)
References: <f0e65c090612122102o327ac693u2f24a74a9ba973ef@mail.gmail.com> <20061213112004.59cb186c@localhost.localdomain> <45841B20.9030402@pobox.com> <458884B2.9080802@gmail.com> <45888653.6080702@pobox.com> <4588A37F.9040102@gmail.com>
In-Reply-To: <4588A37F.9040102@gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> I'm just gonna ack Alan's patch.
> 
> * ATA_FLAG_NO_LEGACY is not really used widely (and thus LLDs don't set
> it rigorously).  I think it should be removed once we get initialization
> model right.
> 
> * I'm really reluctant to add more LLD-specific knowledge into libata
> core.  We're already carrying too much due to the current init model
> (libata should initialize host according to probe_ent, so many
> weirdities should be represented in probe_ent in a form libata core
> understands).
> 
> * The idea of clearing simplex for unknown controllers scares the hell
> out of me.  where's mummy...
> 
> So, I'll ask bug reporter of #7590 to test it.

Aieee... uli sata controller doesn't allow simplex bit to be cleared.

http://bugzilla.kernel.org/show_bug.cgi?id=7590#c31

I'll post ATA_FLAG_IGN_SIMPLEX patch soon.

-- 
tejun
