Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbSBNBMs>; Wed, 13 Feb 2002 20:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289290AbSBNBMi>; Wed, 13 Feb 2002 20:12:38 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:32978 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S287616AbSBNBMX>; Wed, 13 Feb 2002 20:12:23 -0500
Message-ID: <3C6B0DF8.10209@drugphish.ch>
Date: Thu, 14 Feb 2002 02:08:08 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ver_linux script updates
In-Reply-To: <3C6ADCAA.6080600@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

David Ford wrote:
> I've been working on an update to the ver_linux script and I'm looking 
> for comment and help in improving the accuracy of reported information.
> The script is at http://stuph.org/ver_linux
> 
> Please provide feedback on it.

o your script assumes bash as /bin/sh. Is this ok with everyone? Is
   there noone running a Bourne shell only? printf and declare are not
   in the standard Boune shell, IIRC.
o the script hangs when calling loadkeys, because loadkeys without
   arguments waits forever. A fix is to pass "loadkeys -V" as third
   argument to pv().
o if you assume bash why don't you try to convert all of the code into
   bash (inline functions) instead of using awk and sed like the old code
   did?
o your script indicates that one should check for "not found/error" but
   this never appears, it should be "error getting version, try manually"
o the old script separated the loaded kernel modules with a space, the
   new code with a '\n'
o the old code correctly detects my "kbd" version, the new not, because
   you use setleds which on my machine reports: "KDGKBLED: Invalid
   argument"

Why do you want to change this tool? To me it seems like an endless task 
because people don't code according to standards. For example if 
everyone could stick to let's say that 'progname --version' prints the 
version, things would be a lot easier.

Cheers,
Roberto Nibali, ratz

