Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277717AbRJLOk7>; Fri, 12 Oct 2001 10:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277718AbRJLOku>; Fri, 12 Oct 2001 10:40:50 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:1806 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277717AbRJLOkm>;
	Fri, 12 Oct 2001 10:40:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now 
In-Reply-To: Your message of "Fri, 12 Oct 2001 13:14:41 +0100."
             <20283.1002888881@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Oct 2001 00:40:47 +1000
Message-ID: <7892.1002897647@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001 13:14:41 +0100, 
David Woodhouse <dwmw2@infradead.org> wrote:
>kaos@ocs.com.au said:
>>  I was going to do it that way.  The problem is that it gives no
>> indication if the module has been checked or not.  Adding
>> EXPORT_NO_SYMBOLS says that somebody has reviewed the module and
>> decided that exporting no symbols is the correct behaviour.  It is the
>> difference between no maintainer and a maintained module. 
>
>Just change the default to no exported symbols, and a single depmod pass
>will tell you what broke because it's no longer exporting symbols which are
>required by something else. There's no need to add the EXPORT_NO_SYMBOLS
>cruft all over the place.

Your approach is "make an incompatible change and see what breaks, then
scramble to fix it".  My approach is "get ready for this change so we
can have a clean cutover".  Also EXPORT_NO_SYMBOLS is the only way to
clean up 2.4 and 2.2 kernels, there is no option to make an
incompatible change to modutils there.

