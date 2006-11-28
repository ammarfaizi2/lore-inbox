Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935762AbWK1Jqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935762AbWK1Jqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 04:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935767AbWK1Jqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 04:46:31 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:48773 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S935762AbWK1Jqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 04:46:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JmNwZMnK2u2f3mcsH1oOuVPi5UTUA1vljZmqhVhD1vwsgjL4bw9j+aZxsF/xMm6lYwiVFAIUOxneRwjMF+owH9S3TXk7VimOYwnOwT/OM2tg6Oc1eUM/mUN621bxYQ6Ov7v0NqgzXKkKsCpJcWKtFdG/qLQO+a+J4AVtYnWWFZc=
Message-ID: <456C056D.2070008@gmail.com>
Date: Tue, 28 Nov 2006 18:46:21 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: avl@logic.at
CC: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
References: <20061122105735.GV6851@gamma.logic.tuwien.ac.at> <20061123170557.GY6851@gamma.logic.tuwien.ac.at> <20061127130953.GA2352@gamma.logic.tuwien.ac.at> <20061127133044.28b8b4ed@localhost.localdomain> <20061127160144.GB2352@gamma.logic.tuwien.ac.at> <20061127163328.3f1c12eb@localhost.localdomain> <20061127175647.GD2352@gamma.logic.tuwien.ac.at> <20061127181033.58e72d9a@localhost.localdomain> <20061127182943.GE2352@gamma.logic.tuwien.ac.at> <20061127195940.1b90a897@localhost.localdomain> <20061128092930.GF2352@gamma.logic.tuwien.ac.at>
In-Reply-To: <20061128092930.GF2352@gamma.logic.tuwien.ac.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Leitgeb wrote:
> On Mon, Nov 27, 2006 at 07:59:40PM +0000, Alan wrote:
>>> size remains still constant, and the exceeding damaged sectors are 
>>> auto-"hidden" by the drive by means of HPA.
>>> Still incorrect?
>> Still incorrect. HPA has nothing to do with damaged sectors. The damaged
>> sectors are replaced from a pool of sectors that are reserved for this
>> purpose.
> 
> Please re-read my previous mail.   I *explicitly* wrote that
> I'm talking about drives, whose "reserved pool of extra/spare
> sectors" was already exhausted. 
> 
> Considering that: still incorrect?

Yeap, if the drive has run out of spare sectors, bad sectors will no 
longer get better after being written to.  The drive will *never* *ever* 
get shorter.

-- 
tejun
