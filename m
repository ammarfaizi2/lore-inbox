Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281646AbRKUH2y>; Wed, 21 Nov 2001 02:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281648AbRKUH2o>; Wed, 21 Nov 2001 02:28:44 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:55301 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281646AbRKUH2e>;
	Wed, 21 Nov 2001 02:28:34 -0500
Message-Id: <5.1.0.14.0.20011121181459.01fabce0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Nov 2001 18:28:28 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
  opcode
Cc: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011120.230914.00464304.davem@redhat.com>
In-Reply-To: <003401c1725a$975ad4e0$f5976dcf@nwfs>
 <000601c17259$59316630$f5976dcf@nwfs>
 <20011120.225655.85404918.davem@redhat.com>
 <003401c1725a$975ad4e0$f5976dcf@nwfs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:09 PM 20/11/01 -0800, David S. Miller wrote:
>If you patch sources files of the main kernel, you have to
>rebuild the dependencies.
>
>Why does this seem illogical to you?

Maybe the way to stop this sort of problem is to enforce it in the kernel 
build procedure/Makefiles (and/or in the module's build procedure, if it's 
separate to the kernel's).

Eg: Anything that produces output code (bzImage, modules, etc) should fail 
if .config is newer than any of the dependencies. Maybe even spit out a 
"You need to run 'make dep' before using 'make bzImage'" or something like 
that. If they really want to get round it, they can play with 'touch'.

This seems perfectly logical to me.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

