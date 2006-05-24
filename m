Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWEXQnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWEXQnE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWEXQnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:43:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:19120 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750729AbWEXQnB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:43:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uQh7g1BczxUPXlUTpW9f0821FlcnS9atJ8t4uK6XjasAQIZr0K4ExIsDc+zzwrIsDSM+JjxERrwnlJPLbURLCbM4BeSm+/FRHBGKk4LDHoMQQ5q0191UwOUi4Y9rKxtACYCvonAds6yK63uRvGrdDS1zzakYJgtAIh3ITAn1z+4=
Message-ID: <305c16960605240942s3cdea896sf095d6e462ca03d1@mail.gmail.com>
Date: Wed, 24 May 2006 13:42:59 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "D. Hazelton" <dhazelton@enter.net>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <4474891D.9010205@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>
	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>
	 <44747432.1090906@ums.usu.ru>
	 <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>
	 <4474891D.9010205@ums.usu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
> Now suppose this.
>
> The kernel has to save the video memory contents somewhereto restore it after
> pressing Enter. This may swap something out. Whoops, swap is on that failed disk.
>
> Or: lock the memory in advance, to avoid the use of swap. But this is not better
> than doing the same thing from a userspace application that shows a pop-up
> ballon with the contents of this oops. And it won't be affected by a disk
> failure, because it has everything already in memory.

If you have enough video memory, you may use that to save the contents
of the screen.
If you dont, then save it in main memory. if you dont have space
there, then i guess not saving the contents is acceptable.
