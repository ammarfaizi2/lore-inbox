Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWBHOvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWBHOvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWBHOvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:51:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29647 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030417AbWBHOvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:51:11 -0500
Message-ID: <43EA055B.5090903@watson.ibm.com>
Date: Wed, 08 Feb 2006 09:51:07 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <20060208045614.GB26692@MAIL.13thfloor.at> <20060208143813.GA2512@sergelap.austin.ibm.com>
In-Reply-To: <20060208143813.GA2512@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Herbert Poetzl (herbert@13thfloor.at):
> 
>>>3) How do we refer to namespaces and containers when we are not members?
>>>   - Do we refer to them indirectly by processes or other objects that
>>>     we can see and are members?
>>
>>the process will be an unique identifier to the 
>>namespace, but it might not be easy to use it, so
>>IMHO it might at least make sense to ...
> 
> 
> Especially from userspace.  If I want to start a checkpoint on a
> container, but I have to use the process to identify the
> container/namespace, well I can't uniquely specify the process by pid
> anymore...
> 
> -serge
> 

Well we first can agree that througout all processes/tasks of a container
the namespaces used are the same.
Hence looking at the init_task of each container is sufficient.

Restricting visibility to the default container makes sense to me,
because one is not supposed to be able to look into another container.

However, in the global context we do have pid that we can use.

-- Hubertus

