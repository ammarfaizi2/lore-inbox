Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVCFMyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVCFMyV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 07:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVCFMyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 07:54:21 -0500
Received: from mta13.adelphia.net ([68.168.78.44]:44960 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S261393AbVCFMyQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 07:54:16 -0500
Message-ID: <422AFD76.7050005@adelphia.net>
Date: Sun, 06 Mar 2005 07:54:14 -0500
From: Tom Horsley <tomhorsley@adelphia.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace and setuid problem
References: <422A639A.5090603@adelphia.net> <jeu0npkm5m.fsf@sykes.suse.de>
In-Reply-To: <jeu0npkm5m.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:

>Tom Horsley <tomhorsley@adelphia.net> writes:
>
>  
>
>>If I exec a setuid program under ptrace, I can read the image via
>>PEEKDATA requests.
>>    
>>
>
>Only CAP_SYS_PTRACE capable processes get suid/sgid semantics under
>ptrace, or can attach to a privileged processes.
>
>Andreas.
>
>  
>
I realize the program under ptrace is no longer running setuid, but it 
is still running,
and the debugger can examine the process memory. With most setuid programs
being installed execute-only with no read access, isn't it a security 
problem that
I can get read access anyway (at least to the parts of the file that are 
in LOAD
segments)?

(Although I do notice that my suse 9.2 system has /usr/bin/sudo 
installed readable -
it is only my fedora core 3 system that has it execute only - just to 
pick a sample
setuid program).

Maybe setuid shouldn't even be the question, maybe the issue should be that
ptrace can read parts of program files that have no read access.

