Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277636AbRJLMBh>; Fri, 12 Oct 2001 08:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277639AbRJLMB0>; Fri, 12 Oct 2001 08:01:26 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33037 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277636AbRJLMBW>;
	Fri, 12 Oct 2001 08:01:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now 
In-Reply-To: Your message of "Fri, 12 Oct 2001 06:04:20 -0400."
             <20011012060419.A1649@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Oct 2001 21:37:15 +1000
Message-ID: <7202.1002886635@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001 06:04:20 -0400, 
Benjamin LaHaise <bcrl@redhat.com> wrote:
>On Thu, Oct 11, 2001 at 09:45:58PM +1000, Keith Owens wrote:
>> In current modutils, a module that does not export symbols and does not
>> say EXPORT_NO_SYMBOLS will default to exporting all symbols.  This is a
>> hangover from kernel 2.0 and will be removed when modutils 2.5 appears,
>> shortly after the kernel 2.5 branch is created.
>> 
>> Starting with modutils 2.5, modules must explicitly say what their
>> intention is for symbols.  That will break a lot of existing modules.
>
>Isn't EXPORT_NO_SYMBOLS the default case for 99.44% of modules?  It seems 
>to me that the lameness incurred in adding an EXPORT_NO_SYMBOLS line to 
>each and every driver that one writes is a pointless additional hoop to 
>jump through.  I'd rather break the modules that are relying on behaviour 
>that was deprecated several *years* ago than go through another make-work 
>project.

I was going to do it that way.  The problem is that it gives no
indication if the module has been checked or not.  Adding
EXPORT_NO_SYMBOLS says that somebody has reviewed the module and
decided that exporting no symbols is the correct behaviour.  It is the
difference between no maintainer and a maintained module.

