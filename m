Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbULMTnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbULMTnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbULMTji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:39:38 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:52390 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261314AbULMSlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:41:17 -0500
Message-ID: <41BDE2CF.9060402@austin.rr.com>
Date: Mon, 13 Dec 2004 12:43:27 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: cifs large write performance improvements to Samba
References: <41BDC9CD.60504@austin.rr.com> <20041213092057.5bf773fb.cliffw@osdl.org> <41BDE0B4.6020003@austin.rr.com>
In-Reply-To: <41BDE0B4.6020003@austin.rr.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white wrote:

>
>> On Mon, 13 Dec 2004 10:56:45 -0600
>> Steve French <smfrench@austin.rr.com> wrote:
>>
>> If only someone could roll all of the key fs tests into a set of 
>> scripts which could generate one regularly updated set of test status 
>> chart ... one for each of XFS, JFS, ext3, Reiser3, CIFS (against 
>> various servers, Samba version etc), NFSv2, NFSv3, NFSv4 (against 
>> various servers), AFS but that would be a lot of work (not to run) 
>> but the first time writing/setup of the scripts to launch the tests 
>> in the right order since some failures may be expected (at least for 
>> the network filesystems) due to hard to implement features (missing 
>> fcntls, dnotify, get/setlease, differences in byte range lock 
>> semantics, lack of flock etc.) and also since the most sensible NFS, 
>> AFS and CIFS tests would involve more than one client (to test 
>> caching/oplock/token management semantics better) but no such fs 
>> tests AFAIK exist for Linux.
>>
>>
>>
>> We ( OSDL ) would be very interested in this sort of testing. We have 
>> some fs tests
>> wrappered currently
>> cliffw
>> OSDL
>>
>>
>
The other thing I forgot to mention ... we used to have a concept of 
"performance regression testing" (to make sure that we had not gotten a 
lot slower on the latest rc) - not just runs on every release candidate 
of a few complex benchmark tests (like SpecWeb or Netbench or some 
enterprise Java perf test) but the idea was to run on every rc an fs 
microbenchmark (more like iozone) to ensure that we did not have some 
small functional problem in an fs or mm subsystem was causing big, 
noticeable degradation in performance (large read or small read or large 
write or small write, random or sequential etc.). I have not seen anyone 
doing that on Linux in an automated fashion (e.g running iozone 
automated every time a new 2.6.x.rc on a half a dozen of the fs - simply 
to verify that things had not gotten drastically worse on a particular 
fs due to a bug or sideffect of a global VFS change).

