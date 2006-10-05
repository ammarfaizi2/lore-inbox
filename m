Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWJEQ5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWJEQ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWJEQ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:57:25 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:11197 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750978AbWJEQ5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:57:24 -0400
Message-ID: <45253A2F.4040400@student.ltu.se>
Date: Thu, 05 Oct 2006 19:00:31 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1: true/false enum in linux/stddef.h fails glibc-2.4
 compile
References: <20061004155155.GD17660@pool-71-123-69-209.wma.east.verizon.net> <1159977424.3000.23.camel@laptopd505.fenrus.org>
In-Reply-To: <1159977424.3000.23.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-10-04 at 11:51 -0400, Eric Buddington wrote:
>   
>> There is an enum contained in some recent -mm versions of
>> linux/stddef.h which seems to be horking my glibc-2.4 compile:
>>
>> enum {
>>         false   = 0,
>>         true    = 1
>> };
>>
>> One way or another (I can't find where), 'true' and 'false' are
>> getting defined to 1 and 0, turning the above into enum { 0=0, 1=1 },
>> which though undeniable is not compilable.
>>     
>
> I think you're making the mistake of using kernel headers for
> userspace...... rather than the cleaned up headers.
>   
I think so too. glibc-2.4 #includes stdbool.h which have false/true 
defined as 0/1.

Richard Knutsson

