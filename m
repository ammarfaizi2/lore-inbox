Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbVLWN1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbVLWN1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 08:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbVLWN1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 08:27:35 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:44209 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030524AbVLWN1e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 08:27:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QeKuy+r3vI2kK2nUadwI5MhJXBfXU+r1E1K3v5Fp/jO+y/UNQDpmIb/J/96zeFmjpikdYbZGRc3R9wNh73ZYtGk15pg2gnJOtth9hSoUJu+Sn6pXRNDOUFV8MwCfzDznLquAr9jbMtG2YXxVCN/1og3qM/laSE3sB6FZom0KvZA=
Message-ID: <58cb370e0512230527l55810d0fif13d75f35723c1c3@mail.gmail.com>
Date: Fri, 23 Dec 2005 14:27:33 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: 2.6.15rc6: ide oops+panic
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <43AB20DA.2020506@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43AB20DA.2020506@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/22/05, Andreas Steinmetz <ast@domdv.de> wrote:
> Attached are boot messages and panic captured via serial console, as
> well as the system config.

Driver OOPS-es on handling write barrier request (on finishing pre-flush)
because REQ_STARTED flag is not set in __ide_end_request()
but I don't see how this can happen, maybe something has changed
in the block layer...  Does 2.6.14 work for you?

Does mounting ext3 with "barrier=0" option workaround the problem?

Thanks,
Bartlomiej
