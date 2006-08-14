Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWHNQWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWHNQWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWHNQWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:22:19 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:45416 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751490AbWHNQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:22:17 -0400
Message-ID: <44E09A19.9050205@de.ibm.com>
Date: Mon, 14 Aug 2006 17:43:21 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       netdev <netdev@vger.kernel.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
References: <44D99EFC.3000105@de.ibm.com> <20060811205624.GE479@krispykreme> <20060814112656.GC10164@wohnheim.fh-wedel.de> <20060814143842.GM479@krispykreme>
In-Reply-To: <20060814143842.GM479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anton Blanchard wrote:
>> Is a conditional cheaper than a divide?  In case of a misprediction I
>> would assume it to be significantly slower and I don't know the ratio
>> of mispredictions for this branch.
> 
> A quick scan of the web shows 40 cycles for athlon64 idiv, and its
> similarly slow on many other cpus. Even assuming you mispredict every
> branch its going to be a win.
> 
> Anton

as our queue size is always a power of 2, we simply use:
i++;
i &= (ringbufferlength - 1)

So we can get along without the if.

Jan-Bernd


