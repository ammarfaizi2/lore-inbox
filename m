Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUJQRkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUJQRkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbUJQRkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:40:13 -0400
Received: from relay.pair.com ([209.68.1.20]:26892 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269221AbUJQRi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:38:59 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4172A0ED.9040906@kegel.com>
Date: Sun, 17 Oct 2004 09:42:21 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared
 doesn't work well
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org> <20041016204001.B20488@flint.arm.linux.org.uk> <20041016220427.GE8765@mars.ravnborg.org> <20041017165718.GB23525@mail.13thfloor.at>
In-Reply-To: <20041017165718.GB23525@mail.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
>>>>>Converting .S -> .s is useful for debugging - please don't cripple the
>>>>>kernel developers just because some filesystems are case-challenged.
>>>>
>>>>Does the debug tools rely on files named *.s then?
>>>>
>>>>There are today ~1400 files named *.S in the tree, but none named *.s.
>>>>So my idea was to do it like:
>>>>*.S => *.asm => *.o
>>>>But if this breaks some debugging tools I would like to know.
>>>
>>>*.asm is nonstanard naming.  If we have to support case-challenged
>>>filesystems, please ensure that the rest of the nonbroken world can
>>>continue as they have done for the last few decades and live happily
>>>unaffected by these problems.
>>
>>I still do not see how a kernel developer are affected by changing
>>the extension of an intermidiate file - please explain.
> 
> hmm, maybe because they expect the output of the
> preprocessed assembly code to have the prefix .s
> instead of .asm (see gcc man page and play with
> gcc -S)

The only .s/.S ambiguities that need resolving are intermediate files,
so fixing them should only require changing a few Makefile rules.
Let's wait and see what the patch looks like before we
argue about it; maybe it will be simple to make everybody
happy here (well, except those who hate the idea of
letting anyone compile Linux kernels on Cgywin or MacOSX).
- Dan


-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
