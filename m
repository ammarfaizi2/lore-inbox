Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWJ3OX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWJ3OX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWJ3OX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:23:28 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:43187 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751769AbWJ3OX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:23:27 -0500
Message-ID: <454609DE.9060901@openvz.org>
Date: Mon, 30 Oct 2006 17:19:10 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, menage@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <20061030024320.962b4a88.pj@sgi.com>
In-Reply-To: <20061030024320.962b4a88.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> vatsa wrote:
>> C. Paul Menage's container patches
>>
>> 	Provides a generic heirarchial ...
>>
>> Consensus/Debated Points
>> ------------------------
>>
>> Consensus:
>> 	...
>> 	- Dont support heirarchy for now
> 
> Looks like this item can be dropped from the concensus ... ;).

Agree.

> 
> I for one would recommend getting the hierarchy right from the
> beginning.
> 
> Though I can appreciate that others were trying to "keep it simple"
> and postpone dealing with such complications.  I don't agree.
> 
> Such stuff as this deeply affects all that sits on it.  Get the

I can share our experience with it.
Hierarchy support over beancounters was done in one patch.
This patch altered only three places - charge/uncharge routines,
beancounter creation/destruction code and BC's /proc entry.
All the rest code was not modified.

My point is that a good infrastrucure doesn't care wether
or not beancounter (group controller) has a parent.

> basic data shape presented by the kernel-user API right up front.
> The rest will follow, much easier.
> 
> Good review of the choices - thanks.
> 

