Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130169AbRBAIZI>; Thu, 1 Feb 2001 03:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbRBAIY6>; Thu, 1 Feb 2001 03:24:58 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:32777 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130095AbRBAIYk>;
	Thu, 1 Feb 2001 03:24:40 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@melbourne.sgi.com>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Power usage Q and parallel make question (separate issues) 
In-Reply-To: Your message of "Thu, 01 Feb 2001 00:13:17 -0800."
             <3A791A9D.1B2D0EEA@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Feb 2001 19:24:32 +1100
Message-ID: <15262.981015872@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Feb 2001 00:13:17 -0800, 
LA Walsh <law@sgi.com> wrote:
>Keith Owens wrote:
>> It works, until somebody does this
>> 
>>  make -j 4 modules modules_install
>---
>	But that doesn't work now.  

Agreed, but letting modules_install parallel run increases the risk of
somebody doing that.  Most users will think that they can combine two
parallel runs into a single command, but if they are forced to single
thread modules_install it reduces the risk of user error.

>	A bit of documentation at the beginning of the Makefile would do wonders
>for kernel-developer (not end user, please!) clarity.  I've oft'asked the question
>as to what really is supported.  I've tried things like make dep bzImage modules --
>I noticed it didn't work fairly quickly.  Same with modules/modules_install -- 
>people would probably figure that one out, but just a bit of documentation would
>help even that.  

The 2.5 kbuild system will be fully documented, all the way from
reasons for doing things down to how they are down.  Trust me on this!
I have had too many problems with undocumented changes in kbuild.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
