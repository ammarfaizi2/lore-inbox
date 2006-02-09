Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWBIQio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWBIQio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWBIQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:38:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:25798 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422734AbWBIQin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:38:43 -0500
Message-ID: <43EB7007.5040208@watson.ibm.com>
Date: Thu, 09 Feb 2006 11:38:31 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> <20060209021828.GC9456@ccure.user-mode-linux.org>
In-Reply-To: <20060209021828.GC9456@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> On Wed, Feb 08, 2006 at 05:24:16PM -0700, Eric W. Biederman wrote:
> 
>>To deal with networking there are currently a significant number of
>>variables with static storage duration.  Making those variables global
>>and placing them in structures is neither as efficient as it could be
>>nor is it as maintainable as it should be.  Other subsystems have
>>similar problems.
> 
> 
> BTW, there is another solution, which you may or may not consider to
> be clean.
> 
> That is to load a separate copy of the subsystem (code and data) as a
> module when you want a new instance of it.  The code doesn't change,
> but you probably have to move it around some and provide some sort of
> interface to it.
> 
> I did this to the scheduler last year - see
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=111404726721747&w=2
> 
> 				Jeff
> 


Jeff, interesting, but won't that post some serious scalability issue?
Imaging 100s of container/namespace ?

The namespace is mainly there to identify which data needs to be private
when multiple instances of a subsystem are considered and
encapsulate that data in an object/datastructure !

-- Hubertus

