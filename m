Return-Path: <linux-kernel-owner+w=401wt.eu-S1750835AbXACPDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbXACPDH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXACPDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:03:06 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:59745 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750833AbXACPDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:03:04 -0500
Message-ID: <459BC5A1.5040901@scientia.net>
Date: Wed, 03 Jan 2007 16:02:57 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: lfriedman@nvidia.com
CC: andersen@codepoet.org, Karsten Weiss <K.Weiss@science-computing.de>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org>
In-Reply-To: <20061213202925.GA3909@codepoet.org>
Content-Type: multipart/mixed;
 boundary="------------090904010907030800060507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090904010907030800060507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi everybody.

After my last mails to this issue (btw: anything new in the meantime? I
received no replys..) I wrote again to nvidia and AMD...
This time with some more success.

Below is the answer from Mr. Friedman to my mail. He says that he wasn't
able to reproduce the problem and asks for a testing system.
Unfortunately I cannot ship my system as this is my only home PC and I
need it for daily work. But perhaps someone else here might has a system
(with the error) that he can send to Nvidia...

I cc'ed Mr. Friedman so he'll read your replies.

To Mr. Friedman: What system did you exactly use for your testing?
(Hardware configuration, BIOS settings and so on). As we've seen before
it might be possible that some BIOSes correct the problem.

Best wishes,
Chris.




Lonni J Friedman wrote:
> Christoph,
> Thanks for your email.  I'm aware of the LKML threads, and have spent 
> considerable time attempting to reproduce this problem on one of our 
> reference motherboards without success.  If you could ship a system 
> which reliably reproduces the problem, I'd be happy to investigate further.
>
> Thanks,
> Lonni J Friedman
> NVIDIA Corporation
>
> Christoph Anton Mitterer wrote:
>   
>> Hi.
>>
>> First of all: This is only a copy from a thread to nvnews.net
>> (http://www.nvnews.net/vbulletin/showthread.php?t=82909). You probably
>> should read the description there.
>>
>> Please note that his is also a very important issue. It is most likely
>> not only Linux related but a general nforce chipset design flaw, so
>> perhaps you should forwad this mail to your engineers too. (Please CC me
>> in all mails).
>>
>> Also note: I'm not one of the normal "end users" with simple problems or
>> damaged hardware. I study computer science and work in one of Europes
>> largest supercomputing centres (Leibniz supercomputing centre).
>> Believe me: I know what I'm talking about.... and I'm investigating in
>> this issue (with many others) for some weeks now.
>>
>> Please answer either to the specific lkml thread, to the nvnews.net post
>> or directly to me (via email).
>> And I'd be grateful if you could give me email-addresses from your
>> developers or enginers, or even better, forward this email to them and
>> CC me. Of course I'll keep their emails-addresses absolutely confident
>> if you wish.
>>
>> Best wishes,
>> Christoph Anton Mitterer.
>> Munich University of Applied Sciences / Department of Mathematics and
>> Computer Science
>> Leibniz Supercomputing Centre / Department for High Performance
>> Computing and Compute Servers
>>
>>
>>
>>
>> Here is the copy:
>> Hi.
>>
>> I've already tried to "resolve" this via the nvidia knowledgebase but
>> either they don't want to know about that issue or there is noone who is
>> competent enought to give information/solutions about it.
>> They finally pointed me to this fourm and told me that Linux
>> <http://www.nvnews.net/vbulletin/showthread.php?t=82909#> support would
>> be handled here (they did not realise that this is probably a hardware
>> <http://www.nvnews.net/vbulletin/showthread.php?t=82909#> flaw and not
>> OS related).
>>
>> I must admit that I'm a little bit bored with Nvidia's policy in such
>> matters and thus I only describe the problem in brief.
>> If here is any competent chipset engineer who reads this, than he might
>> read the main discussion-thread (and some spin-off threads) of the issue
>> which takes place at the linux-kernel mailing list (again this is
>> probably not Linux related).
>> You can find the archive here:
>> http://marc.theaimsgroup.com/?t=116502121800001&r=1&w=2
>> <http://marc.theaimsgroup.com/?t=116502121800001&r=1&w=2>
>>
>>
>> Now a short description:
>> -I (and many others) found a data corruption issue that happens on AMD
>> Opteron / Nvidia chipset systems
>> <http://www.nvnews.net/vbulletin/showthread.php?t=82909#>.
>>
>> -What happens: If one reads/writes large amounts of data there are errors.
>> We test this the following way: Create some test data (huge amounts
>> of),.. make md5sums of it (or with other hash algorithms), then verify
>> them over and over.
>> The test shoes differences (refer the lkml thread for more information
>> about this). Always at differnt files (!!!!). It may happen at read AND
>> write access <http://www.nvnews.net/vbulletin/showthread.php?t=82909#>.
>> Note that even for affected users the error occurs rarely (but this is
>> of course still far to often): My personal tests shows about the following:
>> Test data: 30GB (of random data), I verify sha512sum 50 times (that is
>> what I call one complete test). So I verify 30*50GB. In one complete
>> test there are about 1-3 files with differences. With about 100
>> corrupted bytes (at leas very low data sizes, far below an MB)
>>
>> -It probably happens with all the nforce chipsets (see the lkml thread
>> where everybody tells his hardware)
>>
>> -The reasons are not single hardware defects (dozens of hight quality
>> memory <http://www.nvnews.net/vbulletin/showthread.php?t=82909#>, CPU,
>> PCI bus, HDD bad block scans, PCI parity, ECC, etc. tests showed this,
>> and even with different hardware compontents the issue remained)
>>
>> -It is probably not an Operating System related bug, although Windows
>> won't suffer from it. The reason therefore is, that windows is (too
>> stupid) ... I mean unable to use the hardware iommu at all.
>>
>> -It happens with both, PATA and SATA disk. To be exact: It is may that
>> this has nothing special to do with harddisks at all.
>> It is probably PCI-DMA related (see lkml for more infos and reasons for
>> this thesis).
>>
>> -Only users with much main memory (don't know the exact value by hard
>> and I'm to lazy to look it up)... say 4GB will suffer from this problem.
>> Why? Only users who need the memory hole mapping and the iommu will
>> suffer from the problem (this is why we think it is chipset related).
>>
>> -We found two "workarounds" but these have both big problems:
>> Workaround 1: Disable Memory Hole Mapping in the system BIOS at all.
>> The issue no longer occurs, BUT you loose a big part of your main memory
>> (depending on the size of the memhole, which itself depends on the PCI
>> devices). In my case I loose 1,5GB from my 4GB. Most users will probably
>> loose 1GB.
>> => inacceptable
>>
>> Workaround 2: As told Windows won't suffer from the problem because it
>> always uses an software iommu. (btw: the same applies for Intel CPUs
>> with EMT64/Intel 64,.. these CPUs don't even have a hardware iommu).
>> Linux is able to use the hardware iommu (which of course accelerates the
>> whole system).
>> If you tell the kernel (Linux) to use a software iommu (with the kernel
>> parameter iommu=soft),.. the issue won't appear.
>> => this is better than workaround 1 but still not really acceptable.
>> Why? There are some following problems:
>>
>> The hardware iommu and systems with such big main memory is largely used
>> in computing centres. Those groups won't abdicate the hwiommu in
>> general, simply because some Opteron (and perhaps Athlon) / Nvidia
>> combinations make problems.
>> (I can tell this because I work at the Leibniz Supercomputing Centre,..
>> one of the largest in Europe)
>>
>> But as we don't know the exact reason for the issue, we cannot
>> selectively switch the iommu=soft for affected
>> mainboards/chipsets/cpu-steppings/and alike.
>>
>> We'd have to use a kernel wide iommu=soft as a catchall solution.
>> But it is highly unlikely that this is accepted by the Linux community
>> (not to talk about end users like the supercomputing centres) and I
>> don't want to talk about other OS'es.
>>
>>
>> So we (and of course all, and especially professional, customers) need
>> Nvidias help.
>>
>> Perhaps this might be solvable via BIOS fixes, but of course not by the
>> stupid-solution "disable hwiommu via the BIOS".
>> Perhaps the reason is a Linux kernel bug (although this is highly unlikely).
>> Last but not least,.. perhaps this is AMD Opteron/Athlon (Note: These
>> CPUs have the memory controllers directly integrated) issue and/or
>> Nvidia nforce chipset issue.
>>
>> Regards,
>> Chris.
>> *
>> btw: For answers from Nvidia engineers/developers or end-users who
>> suffer from that issue too,... please post it to the lkml thread (see
>> above for the link) and if not possible here.
>> You may even contact me via email (calestyo@scientia.net) or personal
>> messages.*
>>
>> PS: Please post any other resources/links to threads about this or
>> similar problems.
>>     
>
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
>
>   


--------------090904010907030800060507
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------090904010907030800060507--
