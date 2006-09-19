Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWISAZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWISAZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWISAZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:25:36 -0400
Received: from tresys.irides.com ([216.250.243.126]:36103 "HELO
	exchange.columbia.tresys.com") by vger.kernel.org with SMTP
	id S1030332AbWISAZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:25:35 -0400
Message-ID: <450F38F7.6080006@gentoo.org>
Date: Mon, 18 Sep 2006 20:25:27 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: David Madore <david.madore@ens.fr>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
 3/4: introduce new capabilities
References: <20060918160217.97076.qmail@web36601.mail.mud.yahoo.com>
In-Reply-To: <20060918160217.97076.qmail@web36601.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0637-2, 09/15/2006), Outbound message
X-Antivirus-Status: Clean
X-OriginalArrivalTime: 19 Sep 2006 00:25:34.0526 (UTC) FILETIME=[1F6015E0:01C6DB82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler wrote:
> --- Joshua Brindle <method@gentoo.org> wrote:
>
>   
>> And that is just practical stuff, there are still
>> problems with
>> embedding policy into binaries all over the system
>> in an entirely
>> non-analyzable way, and this extends to all
>> capabilities, not just the
>> open() one.
>>     
>
> Your assertion that directly associating
> the capabilities with the binary cannot
> be analysed is demonstrably incorrect,
> reference Common Criteria validation
> reports CCEVS-VR-02-0019 and CCEVS-VR-02-0020.
>  
> The first system I took through evaluation
> (that is, independent 3rd party analysis) stored
> security attributes in a file while the second
> and third systems attached the attributes
> directly (XFS). The 1st evaluation required
> 5 years, the 2nd 1 year. It is possible that
> I just got a lot smarter with age, but I
> ascribe a significant amount of the improvement
> to the direct association of the attributes
> to the file.
Thats great but entirely irrelevant in this context. The patch and caps 
in question are not attached to the file via some externally observable 
property (eg., xattr) but instead are embedded in the source code so 
that it can drop caps at certain points during the execution or before 
executing another app, thus unanalyzable.
