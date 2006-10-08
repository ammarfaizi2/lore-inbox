Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWJHMqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWJHMqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 08:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWJHMqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 08:46:16 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:24146 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751127AbWJHMqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 08:46:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=birDoulJ4ALcxWJIj/KYDfeZkrJQZkLZAoIJc/1juei+zOXOgzsKXzthBlIZwr5GoLuYV4yJQzheY+R98LQMOuO/P3vKLn/Jm3+9z8r+YmpicsUQtvKPKuNaakVl1m21sYnP6y5QDgraIHgLrvnfF+AlEobmCk0keLy+BJ0X+oI=
Message-ID: <452879D5.5020707@gmail.com>
Date: Sun, 08 Oct 2006 13:08:53 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Ed Sweetman <safemode2@comcast.net>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Unable to find root fs with libata only 2.6.18-mm3
References: <45284BE0.7030600@comcast.net>
In-Reply-To: <45284BE0.7030600@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ing linux-ide]

Ed Sweetman wrote:
> My question is, do I still need to compile in scsi disk/cdrom/generic 
> support into my kernel to get libata devices to work or is there some 
> other syntax i'm missing?    Libata detects my drives, but as far as I 
> could see, and it flies by too fast to read, no device nodes were 
> assigned to them.

Yes, you do need to select SCSI high level drivers you need - sd and sr 
should suffice for libata.

> If you do need scsi support, why isn't that done automatically when you 
> select your libata drivers? or at least a pointer in the "Help" dialog 
> to tell you to enable that ?

Probably because no other SCSI low level driver selects high level 
driver automatically.  I agree that we need better help message.  Feel 
free to submit patch.

Thanks.

-- 
tejun

