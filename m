Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbRDPWmu>; Mon, 16 Apr 2001 18:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132385AbRDPWmk>; Mon, 16 Apr 2001 18:42:40 -0400
Received: from james.kalifornia.com ([208.179.59.2]:21602 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S132373AbRDPWmW>; Mon, 16 Apr 2001 18:42:22 -0400
Message-ID: <3ADB65F9.7020902@kalifornia.com>
Date: Mon, 16 Apr 2001 14:36:57 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <Pine.LNX.4.31.0104161427400.13558-100000@phobos.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Richter wrote:

>On Fri, 13 Apr 2001, Pavel Machek wrote:
>
>>>Then a more general user space tool could be used that would do policy
>>>appropriate stuff, ending with init 0.
>>>
>>init _is_ the tool which is right for defining policy on such issues.
>>
>>Take a look how UPS managment is handled.
>>
>
>A power failure is a different thing from a power button press. There are
>users (me for example) who want to have something different then "init 0"
>mapped to the power button, for example a sleep state (since my box
>doesn't have a dedicated sleep button). I doubt there are many people who
>want something else than a shutdown if the power is out (although I think
>there will be with suspend-to-disk working, so we might have to change UPS
>handling here).
>
>My plan for power management was to have a special daemon that would
>decide what to do based on system state (battery status, local time, ...)
>and events (power/sleep button, last user logged out, ...) [I know that
>from a programmer's POV, both are events]. This daemon could, for example,
>make sure that no services are affected, for example by priming WOL and
>entering a not-so-deep sleep state instead of doing a suspend-to-disk if
>someone is still listening on a port after the "shutdown unimportant
>services" scripts have been run.
>
>   Simon
>
(root@qwerty)-(02:32pm Mon Apr 16)-(root)
# cat /etc/inittab | grep -1 CTRL

# Trap CTRL-ALT-DELETE
ca::ctrlaltdel:/sbin/shutdown -t3 -r now 


I believe that what is being referred to is similar.  In which case, you 
can put whatever the bleep you want here and do anything from popup a 
message saying, "Shutdown denied" to immediately poweroff.

-b

-- 
Three things are certain:
Death, taxes, and lost data
Guess which has occurred.
- - - - - - - - - - - - - - - - - - - -
Patched Micro$oft servers are secure today . . . but tomorrow is another story!



