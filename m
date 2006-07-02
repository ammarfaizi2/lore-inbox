Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWGBGMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWGBGMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 02:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWGBGMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 02:12:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:59840 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750774AbWGBGMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 02:12:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ChVz57SJjZB46QUUkRWsLtlxgchtThYwIeIVARjBCD0M7YYI1PSKrV/a2Fd+sa1VXbyY/o3pT5L4g1Lg8onhiXSBLWMhrVlA/+Ihv7tfsL6Kj0N+IaDo9+m3OIm3dxcGb8sIJePk4Yryxe72w4zhpuNjR9WNEd+kohL9JNKe0gk=
Message-ID: <a44ae5cd0607012312v32d05f14u6c5c5b1e8dc94fc6@mail.gmail.com>
Date: Sat, 1 Jul 2006 23:12:37 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44A7511E.4040208@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
	 <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com>
	 <20060701230635.GA19114@mars.ravnborg.org>
	 <44A706C4.7070908@zytor.com> <20060702030121.GA7247@mars.ravnborg.org>
	 <44A73790.5030006@zytor.com>
	 <a44ae5cd0607012105g23a22e67ma3fd2bdd7c9352a4@mail.gmail.com>
	 <44A7511E.4040208@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Miles Lane wrote:
> >
> > CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> >                   $(call cc-option, -fno-stack-protector, ) -fno-common
> > in Makefile.
> >
> > Trying to compile, I get:
> >
> > include/asm/system.h: In function '__set_64bit_var':
> > include/asm/system.h:209: warning: dereferencing type-punned pointer
> > will break strict-aliasing rules
>
> That's because the kernel CFLAGS need to include -fno-strict-aliasing.

Okay, problem solved for me.  Can we get these patches in to the mm tree?

Thanks,
           Miles
