Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWFNE1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWFNE1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 00:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFNE1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 00:27:54 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:14210 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751184AbWFNE1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 00:27:54 -0400
Message-ID: <448F903F.9070108@ens-lyon.org>
Date: Wed, 14 Jun 2006 00:27:43 -0400
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Avuton Olrich <avuton@gmail.com>, Russell Whitaker <russ@ashlandhome.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.19 + gcc-4.1.1
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org> <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com> <448F8C53.5010406@ens-lyon.org> <20060614042007.GD13255@w.ods.org>
In-Reply-To: <20060614042007.GD13255@w.ods.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Wed, Jun 14, 2006 at 12:10:59AM -0400, Brice Goglin wrote:
>   
>> Avuton Olrich wrote:
>>     
>>> On 6/13/06, Russell Whitaker <russ@ashlandhome.net> wrote:
>>>       
>>>> Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
>>>>    compiles ok, installs ok. But, when attempting to load a module, get
>>>>    the following message:  version magic '2.6.16.19via K6 gcc-4.1',
>>>>    should be '2.6.16.19via 486 gcc-3.3'
>>>>         
>>> You may have forgotten to "make modules modules_install"
>>>       
>> Actually, "make modules" does not exist anymore with 2.6. Both built-in
>> and modular stuff are built at the same time.
>> Only "make modules_install" is still required.
>>     
>
> What's this bullshit ?
>
> $ grep ^modules: Makefile
> modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux)
> modules: $(module-dirs)
>   

Sorry, my mistake. Didn't know the target still existed. Anyway, "make"
now implies "make modules" so the latter is not required anymore as long
as you fully rebuild your kernel using the former (which I assume
Russell did since he changed his compiler).

Brice

