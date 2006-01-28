Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWA1Abn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWA1Abn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWA1Abm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:31:42 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:41358 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422737AbWA1Abm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:31:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UlIUbWZj3cI9TooucN9JlUPY3KxDLxwuuzXZbrf4lYe1nxDzDISar7nL779ZEH3gQrd/ShhjkNovdTG1QefLV1A6U7Rmeo4A1hEtB/gDu/vdcJb0YX4kYKjfi4GO61J3Y96M81hA7yr16QC6Ip6PNK/SKgnNvUb104h/nWWvodo=
Message-ID: <cfb54190601271631v3af78d70v8993cae358fe9994@mail.gmail.com>
Date: Sat, 28 Jan 2006 02:31:41 +0200
From: Hai Zaar <haizaar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: vesa fb is slow on 2.6.15.1
In-Reply-To: <43DA5681.2020305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
	 <43D8E1EE.3040302@gmail.com>
	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
	 <43D94764.3040303@gmail.com>
	 <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
	 <43D9B77E.6080003@gmail.com>
	 <cfb54190601270832x29681873i624818603d5db26e@mail.gmail.com>
	 <43DA5681.2020305@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Looks harmless to me.
>
> Can you check /proc/iomem just to verify if that particular address has
> been reserved by the OS.
Relevant iomem entries are:
f0000000-f7ffffff : PCI Bus #40
 f0000000-f7ffffff : 0000:40:00.0
   f0000000-f7ffffff : vesafb
f8000000-f9ffffff : PCI Bus #40
 f8000000-f8ffffff : 0000:40:00.0
 f9000000-f9ffffff : 0000:40:00.0
After I load nvidia.ko, it changes to:
f0000000-f7ffffff : PCI Bus #40
 f0000000-f7ffffff : 0000:40:00.0
   f0000000-f7ffffff : vesafb
f8000000-f9ffffff : PCI Bus #40
 f8000000-f8ffffff : 0000:40:00.0
   f8000000-f8ffffff : nvidia
 f9000000-f9ffffff : 0000:40:00.0

>
> And, are you experiencing any problems with your nvidia card, ie, are
> you able to launch X?
X is working fine. KDE runs, glxgears reports 890fps on full screen (1280x1024)

I usually boot with 'quiet' option, so this error is very evident. I
personally can live with it, but I'll surely get a bunch of mail from
my users reporting the "problem". I hope it will be fixed new next
releases.

Anyway. Thanks a lot for your help guys!
