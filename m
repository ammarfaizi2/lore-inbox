Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932873AbWF2Jmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbWF2Jmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbWF2Jmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:42:50 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:14171 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932873AbWF2Jmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:42:49 -0400
Message-ID: <44A3A08D.6060502@fr.ibm.com>
Date: Thu, 29 Jun 2006 11:42:37 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>	<20060627215859.A20679@castle.nmd.msu.ru>	<m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>	<20060628150605.A29274@castle.nmd.msu.ru>	<44A2FA66.5070303@fr.ibm.com> <m11wt8erjv.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wt8erjv.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>When an outgoing packet has the loopback destination addres, the
>>skbuff is filled with the network namespace. So the loopback packets
>>never go outside the namespace. This approach facilitate the migration
>>of loopback because identification is done by network namespace and
>>not by address. The loopback has been benchmarked by tbench and the
>>overhead is roughly 1.5 %
> 
> 
> Ugh.  1.5% is noticeable.

We will see with all private network namespace ...
> 
> I think it is cheaper to have one loopback device per namespace.
> Which removes the need for a skbuff tag.

Yes, probably.
