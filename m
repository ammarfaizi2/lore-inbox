Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSHULop>; Wed, 21 Aug 2002 07:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSHULop>; Wed, 21 Aug 2002 07:44:45 -0400
Received: from ns1.ionium.org ([62.27.22.2]:63501 "HELO mail.ionium.org")
	by vger.kernel.org with SMTP id <S318144AbSHULoo> convert rfc822-to-8bit;
	Wed, 21 Aug 2002 07:44:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: shared graphic ram hangs kernel since 2.4.3-ac1
Date: Wed, 21 Aug 2002 13:52:29 +0200
User-Agent: KMail/1.4.2
References: <200208201527.51649.jh@ionium.org>
In-Reply-To: <200208201527.51649.jh@ionium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208211352.29994.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok.. i finally managed to get the exact file that causes the problems.


2.4.19-pre6 works.
2.4.19-pre7 doesnt: hangs right after "Ok, booting the kernel"
2.4.19-pre7 with pre6  arch/i386/kernel/setup.c   works ! 
as i dont have any highmem support configured and as i always have to provide 
the option   mem=511M   (due to 1MB shared video ram) i suspect that part of 
setup.c. but as i'm not a kernel hacker, any help would be appreciated.
note: any kernel prior to 2.4.3 was able to boot without the mem=511M option.

http://www.kernel.org/diff/diffview.cgi?css=%2Fdiff%2Fdiff.css;file=%2Fpub%2Flinux%2Fkernel%2Fv2.4%2Ftesting%2Fincr%2Fpatch-2.4.19-pre6-pre7.gz;z=54

shows the diff which causes my problems..
anyone ?

--
Best Regards,
Justin Heesemann
