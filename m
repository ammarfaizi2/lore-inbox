Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVLSOGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVLSOGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVLSOGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:06:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48273 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750743AbVLSOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:06:00 -0500
To: Dave Airlie <airlied@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Dave Hansen <haveblue@us.ibm.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
	<m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	<1133977623.24344.31.camel@localhost>
	<1133978128.2869.51.camel@laptopd505.fenrus.org>
	<1133978996.24344.42.camel@localhost>
	<1133982048.2869.60.camel@laptopd505.fenrus.org>
	<1133993636.30387.41.camel@localhost>
	<1133994002.2869.73.camel@laptopd505.fenrus.org>
	<21d7e9970512120255t4852129bx8f50c02efc59836c@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 19 Dec 2005 07:04:21 -0700
In-Reply-To: <21d7e9970512120255t4852129bx8f50c02efc59836c@mail.gmail.com> (Dave
 Airlie's message of "Mon, 12 Dec 2005 21:55:05 +1100")
Message-ID: <m164pl6v4q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@gmail.com> writes:

>>
>> again the DRM layer needs an audit, I'm not entirely sure if it doesn't
>> get pids from userspace. THe rest of the kernel mostly ought to cope
>> just fine.
>>
>
> Yes yet again, if you can think of it, the drm will have found a way
> to do it :-)
>
> the drmGetClient ioctl passes pids across the user/kernel boundary,
> its the only place I can see in a quick look at the interfaces.... but
> it isn't used for anything as far as I can see except for the dristat
> testing utility..


There are crazier cases in the kernel.  Netlink is my favorite example
it's default ports are the process pid and some locations in the kernel
even assume you are using the default port.

Eric
