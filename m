Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265076AbUD3QcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265076AbUD3QcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUD3QcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:32:04 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:46219 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265076AbUD3QcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:32:00 -0400
Message-ID: <40927F21.9010703@nortelnetworks.com>
Date: Fri, 30 Apr 2004 12:30:25 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Sean Estabrooks <seanlkml@rogers.com>, david@gibson.dropbear.id.au,
       Jeff Garzik <jgarzik@pobox.com>, miller@techsource.com, riel@redhat.com,
       koke@sindominio.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Tigran Aivazian <tigran@aivazian.fsnet.co.uk>, rusty@rustcorp.com.au,
       paul@wagland.net
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet> <40927417.6040100@nortelnetworks.com> <DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:
> 
> Chris,
> 
> people should, before insulting us publicly or make unsubstantiated 
> claims that we "lie" or engage in "illegal" actions, perhaps consult a 
> lawyer, and simultaneously use the opportunity to enquire about the 
> meaning of "slander".

The C string library considers a null to terminate the string.  You added a null after the "GPL". 
It appears to me that this is telling the kernel that the module is licensed as "GPL", even though 
it is obvious to a person reading the source that it isn't.  If someone is given the precompiled 
binary, short of disassembling it or doing research online there is no way for them to know that it 
is not licensed under the GPL, as all the module tools, and the kernel itself, all interpret the 
license string as GPL.

> I repeat, the \0 is purely a technical workaround, done without any 
> mischievous intent. 

I'm sure it was in fact done without mischievous intent.  An argument could be made, however, that 
by inserting the null character you are in fact telling the kernel that the entire module is GPL'd, 
which is obviously not the case.  In addition to that, you are forcing the tainted message to be 
suppressed.  Regardless of whether this caused any developer time to be wasted, the fact remains 
that it *could* have.

 > We didn't try to hide anything since
> the code containing the workaround is open-source, and we even explained 
> back in February the purpose of this workaround on the public hsflinux 
> mailing list, while suggesting that a patch should be sent to 
> effectively take care of the problem. I even apologized to Rusty for not 
> sending that patch ourselves.

I understand that now that this has been brought up on the main kernel mailing list that you are 
trying to fix it in a way that is acceptable to the kernel dev team.  I just think it is unfortunate 
that you shipped code with this workaround in it rather than finding some other way of accomplishing 
what you were trying to do.

Chris

