Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266655AbUFZXRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266655AbUFZXRU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUFZXRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:17:20 -0400
Received: from mailgate0.sover.net ([209.198.87.43]:58071 "EHLO mx0.sover.net")
	by vger.kernel.org with ESMTP id S266443AbUFZXRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:17:16 -0400
Message-ID: <40DE03DF.7090404@sover.net>
Date: Sat, 26 Jun 2004 19:16:47 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
CC: Amit Gud <gud@eth.net>, "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       Alan <alan@clueserver.org>, Pavel Machek <pavel@ucw.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <004e01c45abd$35f8c0b0$b18309ca@home>	 <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>	 <20040625162537.GA6201@elf.ucw.cz> <1088181893.6558.12.camel@zontar.fnordora.org> <40DC625F.3010403@eth.net> <40DC8981.7090703@dynextechnologies.com> <40DCF598.6000206@eth.net> <40DDEC76.8060101@capitalgenomix.com>
In-Reply-To: <40DDEC76.8060101@capitalgenomix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fao, Sean wrote:

> Amit Gud wrote:
>
>> Fao, Sean wrote:
>>
>>> Amit Gud wrote:
>>>
>>>> It cannot be denied that there _are_ applications for such a system 
>>>> that we already discussed and theres a class of users who will find 
>>>> the system useful.
>>>
>>> I personally see no use whatsoever. Why not just allocate 100% of 
>>> the file system to everybody and ignore quota's, entirely?  Each 
>>> user will use whatever he/she requires and when space starts to run 
>>> out, users will manually clean up what they don't need.
>>
>> We should get our basics right first. We _do_ need quotas!! Without 
>> any quota system how are we going to avoid a malicious user  from 
>> taking away all the space to keep other people starving? In EQFS also 
>> this can happen, but we are giving *controlled flexibility* to the 
>> user. He is having some stretching power but not beyond a certain 
>> limit. And do you think users are sincere enough to clean up there 
>> files when they are done?
>
> And I suppose you think that users will be sincere enough to mark 
> files as elastic?  I, for one, already said that I absolutely would 
> *not* mark a single file as elastic.  If I'm using 110 MB and you need 
> an additional 10 MB for storage, you won't be getting it from me 
> because I don't want to come in some morning to find that a file has 
> disappeared.
>
> The system that you're asking for is a system without quotas.  Think 
> about what you're saying.

I think you missed one of the main points - you don't get any extra 
space until you mark some of your files as elastic.
You're right - under this system, nobody would get any space from 
deletion of your files because you would use the system as a normal hard 
quota system - you would mark no files as elastic, and would therefore 
be limited to your quota (in the example you gave, you would not be 
using 110M, because your quota would have limited you to 100M).  If you 
were so kind as to mark something as elastic (say, that recently 
doneloaded install tarball of the Gimp), then you would remove the 
storage taken by those files from your quota usage and would have more 
space available, with the risk that the elastic files might not stick 
around.

Under no circumstance would you lose any file that fits under your quota.

>>> I am totally against the automatic deletion of files and believe 
>>> that all users will _eventually_ walk in on a Monday morning to find 
>>> out that the OS took it upon itself to delete a file that was 
>>> flagged as elastic, that shouldn't have been.  
>>
>> User is the king, he decides what files should be elastic and what 
>> not. This can always be controlled.
>
> Controlled how?  Who is anybody to inform me of what files I 
> need/don't need?

Controlled by you using one of the methods that have been suggested:
a .elastic file/directory structure
/scratch/ space usage
a filesystem that can keep track of these things, and a program like chmod
xattrs and other userspace tools

etc.

- Steve

