Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVDEGTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVDEGTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVDEGTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:19:18 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:32012 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261572AbVDEGTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:19:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HmkITO7aupr39H0uimsu0j5uf6KWgp+MEn7tRDyk3MiISN212yNcbOkrDKMM1C3dvAOoil562mh7PlDhurAJCgZIJxMKQjpau5IF6C83/vE4E7q2nPz057qBx7hLDJKmDzEq9YdGDuxguMpxLcGjznDIMTgiEWzqwyjn6Befy9s=
Message-ID: <42522DD9.7020601@gmail.com>
Date: Tue, 05 Apr 2005 15:19:05 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/13] scsi: move request preps in other
 places into prep_fn()
References: <20050331090647.FEDC3964@htj.dyndns.org>	 <20050331090647.94FFEC1E@htj.dyndns.org>	 <1112292464.5619.30.camel@mulgrave> <20050401052542.GG11318@htj.dyndns.org> <1112639944.5813.66.camel@mulgrave>
In-Reply-To: <1112639944.5813.66.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello, James.

James Bottomley wrote:
> On Fri, 2005-04-01 at 14:25 +0900, Tejun Heo wrote:
> 
>> Ah.. with later requeue path consolidation patches, all requests get
>>their sense buffer cleared during requeueing, which, IMHO, is more
>>logical.  Moving scsi_init_cmd_errh() should come after the patch.
>>Sorry. :-)
>>
>> I'll make another take of this patchset (maybe subset) after issues
>>are resolved.  I'll split and reorder relocation of scsi_init_cmd_errh
>>then.
> 
> 
> Thanks.  It would help me enormously if you explained what bugs you were
> fixing at the top of each patch,

  Well, I'll try harder.

 > and also only do patchsets that are
> dependent on each other (I already have your serial_numer_at_timeout and
> internal_timeout removal patches in the scsi-misc-2.6 tree).

  No problem.  Do you want me to do that now?  Or is it okay to do the 
next take after you review the request_fn rewrite patch?

  Thanks.

-- 
tejun

