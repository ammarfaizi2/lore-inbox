Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVBAJEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVBAJEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBAI4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:56:24 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:50181 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261895AbVBAIyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:54:37 -0500
Message-ID: <41FF45DA.80404@hist.no>
Date: Tue, 01 Feb 2005 10:03:22 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Michael Buesch <mbuesch@freenet.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] "biological parent" pid
References: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de> <200501312309.57464.mbuesch@freenet.de> <Pine.LNX.4.53.0502010035480.19436@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0502010035480.19436@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:

>
>I'm trying to reconstruct the complete history of processes from the 
>BSD accounting records. However, this is not very useful if a large 
>fraction of the processes look as if they were started by init.
>
>The following program will print the history in a form vaguely resembling
>pstree output from the accounting file:
>  
>
Just having those original ppids won't really help you, if the process
is long gone with no trace of what it was.  Consider adding logging to
"fork()" and "exec()" instead of doing this. Then you can reconstruct
history all the way back to the correct executables. 

Helge Hafting
